;; -*- lexical-binding: t -*-

(defvar  dropbox-dir (expand-file-name "~/Documents/dropbox"))
(when (equal system-type 'darwin)
  (when (or (not (file-exists-p dropbox-dir))
            (not (file-symlink-p dropbox-dir)))
    (start-process "lndropbox" "*Messages*" "ln"  "-f" "-s" (expand-file-name "~/Library/Mobile Documents/com~apple~CloudDocs/") dropbox-dir)))


(when (boundp 'pixel-scroll-precision-mode) (pixel-scroll-precision-mode 1))
(setq-default
 inhibit-startup-screen t;隐藏启动显示画面
 initial-scratch-message nil;关闭scratch消息提示
 initial-major-mode 'emacs-lisp-mode ;scratch init mode
 initial-buffer-choice t                ;默认打开scratch buffer

 treesit-max-buffer-size 107374182   ;100m
 gnus-directory "~/maildir/news"
 message-directory "~/maildir/"

 use-dialog-box nil           ;不使用对话框进行（是，否 取消） 的选择，而是用minibuffer
 ns-use-proxy-icon nil        ;macOS: 去掉标题栏的文件图标
 ;; frame-title-format: 显示 [修改标记] 文件名 [项目名]
 frame-title-format
 '(:eval (let* ((file (buffer-file-name))
                (proj-root (or (and (project-current) (project-root (project-current)))
                               (vc-root-dir)))
                (proj-path (when proj-root (abbreviate-file-name proj-root)))
                (rel-path (if (and proj-root file)
                              (file-relative-name file proj-root)
                            (if file (abbreviate-file-name file) (buffer-name)))))
           (if proj-path
               (concat  proj-path " > " rel-path)
             rel-path)))

 ;;中键点击时的功能
 ;;不要在鼠标中键点击的那个地方插入剪贴板内容。
 ;;而是光标在什么地方,就在哪插入(这个时候光标点击的地方不一定是光标的所在位置)

 sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
 ;; sentence-end-double-space nil         ;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。

 remote-file-name-inhibit-cache 60 ;60s default 10s
 backup-by-copying t    ;自动备份
 delete-old-versions t ; 自动删除旧的备份文件
 kept-new-versions 10   ; 保留最近的6个备份文件
 kept-old-versions 10   ; 保留最早的2个备份文件
 version-control t    ; 多次备份
 vc-make-backup-files t
 ;; 备份文件统一放在 ~/.emacs.d/cache/backup_files,避免每个目录生成一些临时文件
 pulse-iterations 3
 large-file-warning-threshold (* 1024 1024 50)       ;打开大文件时不必警告

 send-mail-function 'sendmail-send-it
 ;; mail-addrbook-file (expand-file-name "mail_address" dropbox-dir)

 ;;注意这两个变量是与recentf相关的,把它放在这里,是因为
 ;;觉得recentf与filecache作用有相通之处,
 ;;匹配这些表达示的文件，不会被加入到最近打开的文件中
 recentf-exclude  `("\\.elc$" ,(regexp-quote (concat user-emacs-directory "cache/" ))
                     ,(regexp-quote "~/.cache/")
                    "/cache/recentf"
                    "/TAGS$" "java_base.tag" ".erlang.cookie" "xhtml-loader.rnc" "COMMIT_EDITMSG")
 recentf-max-saved-items 1000
 ring-bell-function 'ignore
 savehist-additional-variables '(corfu-history magit-repository-directories kill-ring)
 ;;when meet long line ,whether to wrap it
 truncate-lines t ;一行过长时 是否wrap显示
 display-line-numbers 'absolute
 long-line-threshold 1000
 large-hscroll-threshold 1000
 syntax-wholeline-max 1000

 fill-column 100
 tramp-adb-prompt "^\\(?:[[:digit:]]*|?\\)?\\(?:[[:alnum:]-]*@[[:alnum:]]*[^#\\$]*\\)?[#\\$][[:space:]]" ;加了一个  "-"
 tramp-shell-prompt-pattern (concat "\\(?:^\\|\r\\)" "[^]#@$%>\n]*#?[]#$@%>] *\\(\e\\[[0-9;]*[a-zA-Z-.] *\\)*")
 comint-prompt-regexp "^[^#$%\n]*[#$%] *"  ;默认 regex 相当于没定义，term-bol 无法正常中转到开头处
 shell-prompt-pattern "^[^#$%\n]*[#$%] *"  ;默认 regex 相当于没定义，term-bol 无法正常中转到开头处
 tramp-default-method "ssh" ;Faster than the default scp
 tramp-verbose 1
 ;; TODO ?
 ;; find-function-C-source-directory "~/repos/emacs/src/"
 Man-notify-method 'bully
 )

 ;; 隐藏原生标题栏
(add-to-list 'default-frame-alist '(undecorated-round . t))

;; 用 tab-bar 显示标题信息（类似 VSCode）
(setq tab-bar-show t)                          ; 始终显示 tab-bar
(setq tab-bar-close-button-show nil)           ; 不显示关闭按钮
(setq tab-bar-new-button-show nil)             ; 不显示新建按钮

;; 自定义 tab-bar 显示内容的函数（精确居中）
(defun vmacs-tab-bar-format-path ()
  "显示项目路径 > 文件相对路径（精确居中 + 颜色区分）"
  (let* ((file (buffer-file-name))
         (proj-root (or (and (project-current) (project-root (project-current)))
                        (vc-root-dir)))
         (proj-path (when proj-root (abbreviate-file-name proj-root)))
         (rel-path (if (and proj-root file)
                       (file-relative-name file proj-root)
                     (if file (abbreviate-file-name file) (buffer-name))))
         ;; 修改标记（红色）
         (modified (if (and file (buffer-modified-p))
                       (propertize "● " 'face '(:foreground "#ff6b6b" :weight bold))
                     ""))
         ;; 项目路径（蓝色）
         (proj-str (if proj-path
                       (propertize proj-path 'face '(:foreground "#4d96ff" :weight bold))
                     ""))
         ;; 分隔符（灰色）
         (sep (if proj-path
                  (propertize " > " 'face '(:foreground "#666666"))
                ""))
         ;; 文件路径
         (file-str (propertize rel-path 'face '(:foreground "#cdd6f4")))
         ;; 完整内容（不含填充）
         (content (concat modified proj-str sep file-str))
         ;; 计算精确居中所需的左侧填充
         (content-width (string-width content))
         (frame-width (frame-width))
         (left-pad (max 0 (/ (- frame-width content-width) 2)))
         ;; 带填充的完整字符串
         (centered-content (concat (make-string left-pad ?\s) content)))
    `((global menu-item ,centered-content ignore))))

;; 设置 tab-bar 格式
(setq tab-bar-format '(vmacs-tab-bar-format-path))

;; 自定义 tab-bar 样式
(custom-set-faces
 '(tab-bar ((t (:height 1.1
                :background "#000000"
                :foreground "#cdd6f4"
                :box (:line-width 4 :color "#000000"))))))
(tab-bar-mode 1)


;; Increase undo limits. Why?
;; .. ability to go far back in history can be useful, modern systems have sufficient memory.
;; Limit of 64mb.
(setq undo-limit 6710886400)
;; Strong limit of 1.5x (96mb)
(setq undo-strong-limit 100663296)
;; Outer limit of 10x (960mb).
;; Note that the default is x100), but this seems too high.
(setq undo-outer-limit 1006632960)
(with-eval-after-load 'vundo
  (setq vundo-roll-back-on-quit nil)
  (setq vundo-glyph-alist vundo-unicode-symbols))


(fset 'yes-or-no-p 'y-or-n-p) ;; 把Yes用y代替

;;(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil);; 启用narrow-to-region ,不再警告
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(with-eval-after-load 'markdown-ts-mode  (add-hook 'markdown-ts-mode-hook #'auto-fill-mode))
;; after-init-hook 所有配置文件都加载完之后才会运行此hook
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq-default auto-mode-alist
              (append
               '(("\\.pyx" . python-mode)
                 ("zsh" . sh-mode)
                 ("SConstruct" . python-mode)
                 ("\\.yml$" . yaml-ts-mode)
                 ("authinfo.gpg" . authinfo-mode)
                 ("\\.yaml$" . yaml-ts-mode)
                 ("\\.lua$" . lua-ts-mode)
                 ("\\.scpt\\'" . applescript-mode)
                 ("\\.applescript$" . applescript-mode)
                 ;; ("crontab\\'" . crontab-mode)
                 ;; ("\\.cron\\(tab\\)?\\'" . crontab-mode)
                 ;; ("cron\\(tab\\)?\\."    . crontab-mode)
                 ("\\.mxml" . nxml-mode)
                 ("\\.proto\\'" . protobuf-mode)
                 ("\\.thrift" . thrift-mode)
                 ("\\.md$" . markdown-ts-mode)
                 ("\\.\\(frm\\|bas\\|cls\\|vba\\|vbs\\)$" . visual-basic-mode)

                 ("\\.rs$" . rust-ts-mode)
                 ("\\.go.txt$" . go-ts-mode)
                 ("\\.go\\'" . go-ts-mode)
                 ("\\.java\\'" . java-ts-mode)

                 ("\\.yaws$" . nxml-mode)

                 ("\\.hrl$" . erlang-mode)
                 ("\\.erl$" . erlang-mode)
                 ("\\.rel$" . erlang-mode)
                 ("\\.app$" . erlang-mode)
                 ("\\.app.src$" . erlang-mode)
                 ("\\.ahk$\\|\\.AHK$" . ahk-mode)
                 ("\\.bat$"   . batch-mode)
                 ("\\.cmd$"   . batch-mode)
                 ("\\.pl$"   . cperl-mode)
                 ("\\.pm$"   . cperl-mode)
                 ("\\.perl$" . cperl-mode)
                 ("\\.sqlo$"  . oracle-mode)
                 ("\\.sqlm$"  . mysql-mode)
                 ("\\.sqlms$"  . sqlserver-mode)
                 ("\\.js$"  . js-mode)
                 ("\\.json$"  . json-ts-mode)
                 ("\\.pac$" . js-mode)
                 ;; ("\\.js$"  . js3-mode)
                 ("\\.txt$" . org-mode)
                 ("\\.mm$" . objc-mode)
                 )
               auto-mode-alist))

(defun scratch-auto-set-major-mode (&optional arg)
  (when (and (string= (buffer-name) "*scratch*")
             (member this-command '(meep-clipboard-killring-yank yank )))
    (set-auto-mode)
    (setq-local write-contents-functions #'scratch-write-contents)
    ))

(advice-add 'yank :after #'scratch-auto-set-major-mode)

(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and buffer-file-name
                       (string= (file-name-extension buffer-file-name) "h")
                       (or (re-search-forward "@\\<interface\\>"
                                              magic-mode-regexp-match-limit t)
                           (re-search-forward "@\\<protocol\\>"
                                          magic-mode-regexp-match-limit t))))
               . objc-mode))

(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (looking-at "[ \t\n]*{[ \t\n]*\""))
               . json-ts-mode))
(global-set-key "\C-j" 'open-line-or-new-line-dep-pos)
(define-key lisp-interaction-mode-map "\C-j" 'open-line-or-new-line-dep-pos)

(global-set-key (kbd "C-a") 'smart-beginning-of-line)
(global-set-key (kbd "C-e") 'smart-end-of-line)

(global-set-key "\C-k" 'vmacs-kill-region-or-line)

(global-set-key "\M-;" 'vmacs-comment-dwim-line)

(global-set-key "\C-x\C-v" 'scratch-buffer)

(global-set-key (kbd "C-c w w") 'browse-url-at-point)


;;; goto-last change
;;快速跳转到当前buffer最后一次修改的位置 利用了undo定位最后一次在何处做了修改
;; (autoload 'goto-last-change "goto-last-change" "Set point to the position of the last change." t)
(autoload 'goto-last-change-reverse "goto-chg.el" "goto last change reverse" t)

(with-eval-after-load 'cc-mode (define-key c-mode-base-map ";" 'vmacs-append-semicolon-at-eol))

;; Quick edit (for use with hammerspoon quick edit)
(defun meain/quick-edit-end ()
  "Util function to be executed on qed completion."
  (interactive)
  (mark-whole-buffer)
  (call-interactively 'kill-ring-save)
  (kill-current-buffer))
(defun meain/quick-edit ()
  "Util function for use with hammerspoon quick edit functionality."
  (interactive)
  (let ((qed-buffer-name (concat "*scratch*" )))
    (switch-to-buffer (generate-new-buffer qed-buffer-name t))
    (sit-for 0.01)
    ;; (evil-paste-after 1)
    (gfm-mode)))

;; (global-set-key (kbd "C-x C-e") 'eval-print-last-sexp)

(provide 'conf-common)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-common.el ends here.
