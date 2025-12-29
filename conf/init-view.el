;;; -*- lexical-binding: t; -*-

;; Dashboard
(dashboard-setup-startup-hook)  ; 只调用一次
(setq dashboard-banner-logo-title nil
      dashboard-startup-banner "~/.emacs.d/theme/motorcycle.png"
      dashboard-items '((recents . 6) (agenda . 12))
      dashboard-show-shortcuts t
      dashboard-set-heading-icons t
      dashboard-set-file-icons t
      dashboard-center-content t
      dashboard-set-init-info nil)

(menu-bar-mode -1)

;; Frame 设置
;; https://github.com/jixiuf/vmacs/blob/master/conf/custom-file.el
;; 如果配置好了， 下面20个汉字与40个英文字母应该等长
;; here are 20 hanzi and 40 english chars, see if they are the same width
;;
;; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa|
;; 你你你你你你你你你你你你你你你你你你你你|
;; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,|
;; 。。。。。。。。。。。。。。。。。。。。|
;; 1111111111111111111111111111111111111111|
;; 東東東東東東東東東東東東東東東東東東東東|
;; ここここここここここここここここここここ|
;; ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ|
;; 까까까까까까까까까까까까까까까까까까까까|
(setq-default window-system-default-frame-alist
              '((ns (height . 0.98) (width . 1.00) (left . 0) (top . 0)
                    (alpha . 88) (border-width . 0) (ns-appearance . dark)
                    (font . "Source Code Pro 20"))))

;; 编码
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8)
      pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)

;; Evil mode-line
(setq evil-mode-line-format '(before . mode-line-front-space)
      evil-normal-state-tag   (propertize "[Normal]")
      evil-emacs-state-tag    (propertize "[Emacs]")
      evil-insert-state-tag   (propertize "[Insert]")
      evil-motion-state-tag   (propertize "[Motion]")
      evil-visual-state-tag   (propertize "[Visual]")
      evil-operator-state-tag (propertize "[Operator]"))

;; TODO/DONE 高亮
(defface font-lock-todo-face nil "Font Lock mode face for TODO." :group 'font-lock-faces)
(defface font-lock-done-face nil "Font Lock mode face for DONE." :group 'font-lock-faces)
(dolist (mode '(c-mode c++-mode java-mode lisp-mode emacs-lisp-mode erlang-mode
                       go-mode actionscript-mode lisp-interaction-mode sh-mode sgml-mode))
  (font-lock-add-keywords
   mode
   '(("\\<\\(FIXME\\|TODO\\|Todo\\|HACK\\|todo\\):" 1 'font-lock-todo-face prepend)
     ("@\\<\\(FIXME\\|TODO\\|Todo\\|HACK\\|todo\\)" 1 'font-lock-todo-face prepend)
     ("\\<\\(DONE\\|Done\\|done\\):" 1 'font-lock-done-face t)
     ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face))))

(global-hl-line-mode)
(set-face-attribute hl-line-face nil :underline nil)
(set-frame-font "Source Code Pro 20" nil t)
(setq ns-use-native-fullscreen nil)

;; Recentf
(setq recentf-auto-cleanup 'never) ; 禁用启动时的自动清理
(recentf-mode 1)
(setq history-length 1000)

;; Winner mode
(winner-mode 1)
(require 'smooth-scrolling)

;; 自动创建父目录
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))
(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)

;; Fill column indicator
(require 'display-fill-column-indicator nil t)
(when (featurep 'display-fill-column-indicator)
  (add-hook 'find-file-hook #'display-fill-column-indicator--turn-on))
(setq-default fill-column 120)

;; 括号高亮
(require 'highlight-parentheses)
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)

;; Modus 主题自定义
(defun my-modus-themes-custom-faces (&optional _)
  (modus-themes-with-colors
    (custom-set-faces
     '(font-lock-comment-face ((t (:inherit modus-themes-slant :slant italic))))
     '(show-paren-match ((t (:foreground "SpringGreen3" :weight bold))))
     '(gnus-summary-normal-ancient ((t (:extend t :foreground "gray"))))
     `(region ((t (:extend t :foreground unspecified :background "#5a5a5a"))))
     `(secondary-selection ((t (:extend t :foreground unspecified :background "#020202")))))))

(add-hook 'modus-themes-after-load-theme-hook #'my-modus-themes-custom-faces)
(add-hook 'after-make-frame-functions #'my-modus-themes-custom-faces)
(my-modus-themes-custom-faces)

;; Use variable width font faces in current buffer
(defun my-buffer-face-mode-variable ()
   "Set font to a variable width (proportional) fonts in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:family "Ubuntu Mono" :width semi-condensed))
   (buffer-face-mode))

 ;; Set default font faces
(add-hook 'org-mode-hook 'my-buffer-face-mode-variable)




;; TODO Don't highlight matches with jump-char - it's distracting
;; (setq jump-char-lazy-highlight-face nil)

(provide 'init-view)
