(when (< emacs-major-version 27) (package-initialize))

(require 'conf-icomplete)
;; (require 'conf-)

(require 'init-view)        ;; 显示相关

(when (member system-type '(gnu/linux darwin)) (require 'conf-sudo))
(require 'conf-space-tab)
(eval-after-load 'ibuffer '(require 'conf-ibuffer)) ;绑定在space l 上，用于列出当前打开的哪些文件
(with-eval-after-load 'protobuf-mode (require 'conf-program-protobuf))
(with-eval-after-load 'css-mode (require 'conf-css))
(with-eval-after-load 'lua (require 'conf-program-lua))

(with-eval-after-load 'sql (require 'conf-sql))


(require 'conf-evil) ;; evil jixiuf
;; mac 上处理evil-mode 与中文输入法
(require 'conf-evil-window)       ;窗口
(require 'conf-evil-clipboard)

;; (when (eq system-type 'darwin) (require 'conf-macos))
(with-eval-after-load 'iedit (require 'conf-iedit))
(require 'conf-common)
(with-eval-after-load 'org (require 'conf-org))

(require 'conf-yasnippet)               ;模版系统
(with-eval-after-load 'compile (require 'conf-compile))
(with-eval-after-load 'cc-mode (require 'conf-program-objc))
(with-eval-after-load 'go-mode (require 'conf-program-golang))
(with-eval-after-load 'python (require 'conf-program-python))


(when (eq system-type 'darwin)
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))
(with-eval-after-load 'dired (require 'conf-dired)) ;emacs文件浏览器，directory 管理理

(require 'conf-wgrep)

;; (require 'conf-centaur-tabs)
(require 'conf-tabs)
(require 'conf-lsp)                    ;ctags gtags 相关，代码跳转
;; (require 'conf-company-mode)            ;补全
(require 'conf-corfu)
(with-eval-after-load 'magit (require 'conf-magit))
;; (require 'conf-magit)

(global-font-lock-mode)
(transient-mark-mode 1)
(save-place-mode t)
(savehist-mode 1)
(recentf-mode 1)
(run-with-idle-timer 300 t 'vmacs-idle-timer) ;idle 300=5*60s
(require 'conf-tmp nil t)

(require 'conf-vterm)

(require 'server)
(unless (server-running-p) (server-start))
(when (> emacs-major-version 27) (load-theme 'modus-vivendi))


;;==============jixiuf======================
;;==============上面和xiuf相同,下面逐步淘汰======================

(require 'conf-evil-toby)        ;; vim操作
;; (require 'conf-git)              ;; git 版本控制 magit的配置
(require 'conf-org-toby)         ;; org mode
(require 'conf-dired-toby)       ;; 文件目录操作
(require 'conf-iedit-toby)
(require 'conf-keybind)          ;; 键位绑定
(global-set-key (kbd "C-;") 'iedit-mode)


;; (evil-collection-define-key 'normal 'magit-mode-map
;;   "q" #'my/quit-magit-buffer)

(setq-default mode-line-format nil)
(setq mode-line-format nil)

(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "chromium"
      browse-url-browser-function gnus-button-url)

(setq
 browse-url-browser-function 'eww-browse-url ; Use eww as the default browser
 shr-use-fonts  nil                          ; No special fonts
 shr-use-colors nil                          ; No colours
 shr-indentation 2                           ; Left-side margin
 shr-width 70  )                              ; Fold text to 70 columns
(require 'org-web-tools)
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


; ===================

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(require 'slime-autoloads)
(put 'upcase-region 'disabled nil)

(setq leetcode-prefer-language "golang")
(setq leetcode-save-solutions t)
(setq leetcode-directory "~/leetcode")


;; (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 101)

(editorconfig-mode 1)


;; (add-hook 'python-mode-hook
;;       (lambda ()
;;         (flycheck-mode)
;;         (flymake-mode -1)
;;         (setq flycheck-pylintrc "~/.pylintrc")))
;; (setq python-check-command "flake8")
;; (setq python-flymake-command "flake8")

(setopt set-mark-command-repeat-pop t)
(setopt confirm-kill-emacs 'yes-or-no-p)
