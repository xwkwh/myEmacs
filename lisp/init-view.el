
(setq-default 
   inhibit-startup-screen t;隐藏启动显示画面
   display-line-numbers 'relative
   )

(require 'use-package)
(use-package dashboard
  :ensure
  :init
  (dashboard-setup-startup-hook)
  :config
  (setq dashboard-banner-logo-title "Happy Emacs")
  ;; (setq dashboard-startup-banner "~/.emacs.d/go.png")
  (setq dashboard-startup-banner nil)
  (setq dashboard-items
        '((recents . 9)
          (projects . 3)
          (agenda . 5)))
  ;; (setq dashboard-items-default-length 10)
)

(require 'popup)
(setq clippy-tip-show-function #'clippy-popup-tip-show)


;; (require 'cnfonts)
;; ;; 让 cnfonts 随着 Emacs 自动生效。
;; (cnfonts-enable) ;
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)
;; (setq cnfonts-use-face-font-rescale t)

;; 隐藏状态栏
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;直接emacs命令打开的窗口相关设置,不要在这里设置字体，否则daemon 启动时字体有可能没创建好，会导致字体设置失败
(setq-default window-system-default-frame-alist                 
	      '( 
		(ns ;; if frame created on mac
		 (height . 0.98)
		 ;; (width . 0.98)
		 (width . 1.00)
		 (left . 0)
		 (top . 0)
		 (alpha . 98)
		 (foreground-color . "#eeeeec")
		 (background-color . "#202020") ;;
		 (background-mode . dark)
		 ;; (font . "Ubuntu Mono-22")
		 ;; (font . "Fira Code-20")
		 ;; (font . "DejaVu Sans Mono-13")
		 ;; (font . "Space Mono-22")
		 ;; (font . "Hack-22")
		 ;; (font . "Envy Code R-20")
		 (font . "Source Code Pro 20")
		 ;; (font . "fantasque sans mono-20")
		 )
		))
;; Use variable width font faces in current buffer
(defun my-buffer-face-mode-variable ()
   "Set font to a variable width (proportional) fonts in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:family "Ubuntu Mono" :width semi-condensed))
   (buffer-face-mode))

 ;; Set default font faces 
(add-hook 'org-mode-hook 'my-buffer-face-mode-variable)


;;(mac-auto-operator-composition-mode)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
; 字体
(create-fontset-from-fontset-spec
 (concat "-*-*-*-*-*--*-*-*-*-*-*-fontset-bigmac"
	 ",han:PingFang SC:size=20"
	 ",symbol:PingFang SC:size=20"
	 ",cjk-misc:PingFang SC:size=20"
         ",bopomofo:PingFang SC:size=20"
         ",kana:Hiragino Sans:size=20"
         ",hangul:Apple SD Gothic Neo:size=23"
         ",latin:Menlo"))
;;;;;;;;;;;;;;;


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

;; (create-fontset-from-fontset-spec
;;    "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-fontset-mymac,
;;  ascii:-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1,
;; han:-*-PingFang SC-normal-normal-normal-*-14-*-*-*-p-0-iso10646-1,
;; cjk-misc:-*-PingFang SC-normal-normal-normal-*-14-*-*-*-p-0-iso10646-1,
;; kana:-*-PingFang SC-normal-normal-normal-*-30-*-*-*-p-0-iso10646-1,
;; hangul:-*-Apple SD Gothic Neo-normal-normal-normal-*-16-*-*-*-p-0-iso10646-1")
;; (add-to-list 'default-frame-alist '(font . "fontset-mymac"))
;; (set-frame-font "fontset-mymac" )


;; (setq buffer-file-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (add-to-list 'default-frame-alist '(font . "Noto Sans Mono-16"))
;; (set-frame-font "Noto Sans Mono-16" 16)
;; (set-default-font "Noto Sans Mono-16" 16） ;

;; (defun create-frame-font-mac()          ;emacs 若直接启动 启动时调用此函数似乎无效
;;   (set-face-attribute
;;    'default nil :font "Menlo 12")
;;   ;; Chinese Font
;;   (dolist (charset '( han symbol cjk-misc bopomofo)) ;script 可以通过C-uC-x=查看当前光标下的字的信息
;;     (set-fontset-font (frame-parameter nil 'font)
;;                       charset
;;                       (font-spec :family "PingFang SC" :size 14)))

;;   (set-fontset-font (frame-parameter nil 'font)
;;                     'kana                 ;script ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ
;;                     (font-spec :family "Hiragino Sans" :size 14))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     'hangul               ;script 까까까까까까까까까까까까까까까까까까까까
;;                     (font-spec :family "Apple SD Gothic Neo" :size 16))

;;   )
;; (when (and (equal system-type 'darwin) (window-system))
;;   (add-hook 'after-init-hook 'create-frame-font-mac))

;; (defun create-frame-font-w32()          ;emacs 若直接启动 启动时调用此函数似乎无效
;;   (set-face-attribute
;;    'default nil :font "Courier New 10")
;;   ;; Chinese Font
;;   (dolist (charset '( han symbol cjk-misc bopomofo)) ;script 可以通过C-uC-x=查看当前光标下的字的信息
;;     (set-fontset-font (frame-parameter nil 'font)
;;                       charset
;;                       (font-spec :family "新宋体" :size 16)))

;;   (set-fontset-font (frame-parameter nil 'font)
;;                     'kana                 ;script ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ
;;                     (font-spec :family "MS Mincho" :size 16))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     'hangul               ;script 까까까까까까까까까까까까까까까까까까까까
;;                     (font-spec :family "GulimChe" :size 16)))

;; (when (and (equal system-type 'windows-nt) (window-system))
;;   (add-hook 'after-init-hook 'create-frame-font-w32))

;; (defun  emacs-daemon-after-make-frame-hook(&optional f) ;emacsclient 打开的窗口相关的设置
;;   ;; (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;   ;; (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;;   ;; (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;;   (with-selected-frame f
;;     (when (window-system)
;;       (when (equal system-type 'darwin) (create-frame-font-mac))
;;       (when (equal system-type 'windows-nt) (create-frame-font-w32))
;;       ;; (set-frame-position f 160 80)
;;       ;; (set-frame-size f 140 50)
;;       ;; (set-frame-parameter f 'alpha 85)
;;       ;; (raise-frame)
;;       )))

;; (add-hook 'after-make-frame-functions 'emacs-daemon-after-make-frame-hook)

;;;;;;;;;;;;;

;;;###autoload
;; (defun create-frame-font-big-mac()          ;emacs 若直接启动 启动时调用此函数似乎无效
;;   (interactive)
;;   (set-face-attribute
;;    'default nil
;;    :font
;;    "Menlo 16"
;;    :fontset "fontset-bigmac"))

;; (create-frame-font-big-mac)

;; 窗口显示文件路径
(setq frame-title-format '("%e " evil-mode-line-format "「"mode-line-buffer-identification "」("  (:propertize ("" mode-name) ) ") "   mode-line-misc-info   "%f  GNU/Emacs"))


;; 修改evil line
(setq evil-mode-line-format '(before . mode-line-front-space))
(setq evil-normal-state-tag   (propertize "[Normal]")
      evil-emacs-state-tag    (propertize "[Emacs]")
      evil-insert-state-tag   (propertize "[Insert]")
      evil-motion-state-tag   (propertize "[Motion]")
      evil-visual-state-tag   (propertize "[Visual]")
      evil-operator-state-tag (propertize "[Operator]"))

(defun samray/set-mode-line-width ()
  "Set mode line width, it is so cool."
  (set-face-attribute 'mode-line nil
		      :box '(:line-height 0)))
(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))
(add-hook 'after-load-theme-hook #'samray/set-mode-line-width)




(defface font-lock-todo-face nil
  "Font Lock mode face used to highlight TODO."
  :group 'font-lock-faces)
(defface font-lock-done-face nil
  "Font Lock mode face used to highlight DONE."

  :group 'font-lock-faces)
(dolist (mode '(c-mode c++-mode java-mode lisp-mode emacs-lisp-mode erlang-mode
                       go-mode
                      actionscript-mode lisp-interaction-mode sh-mode sgml-mode))
  (font-lock-add-keywords
   mode
   '(("\\<\\(FIXME\\|TODO\\|Todo\\|HACK\\|todo\\):" 1  'font-lock-todo-face prepend)
     ("@\\<\\(FIXME\\|TODO\\|Todo\\|HACK\\|todo\\)" 1  'font-lock-todo-face prepend)
     ("\\<\\(DONE\\|Done\\|done\\):" 1 'font-lock-done-face t)
     ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)
     )))

;; (load-theme 'spacemacs-dark t)
;; (load-theme 'material t)
;; (load-theme 'monokai t)
;; (load-theme 'monokai-pro t)
;; (load-theme 'zenburn t)
;; (load-theme 'hc-zenburn t)

;; (require 'doom-themes)

;; ;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; ;; may have their own settings.
;; ;; (load-theme 'doom-one t)
;; (load-theme 'doom-vibrant t)

;; ;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; ;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; ;; or for treemacs users
;; (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;; (doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)


(global-hl-line-mode)


;; (add-to-list'custom-theme-load-path "~/.emacs.d/theme/laguna-theme")
;; (load-theme 'laguna)
; (add-to-list'custom-theme-load-path "~/.emacs.d/theme")
;; (load-theme 'black)
;; (load-theme 'dracula)

;; (load-theme 'chocolate)
;; (load-theme 'zerodark t)
;; Optionally setup the modeline
;; (zerodark-setup-modeline-format)

(load-theme 'darktooth)
;; (load-theme 'dracula)
;; (require 'green-is-the-new-black-theme)

;; (load-theme 'nimbus t)



(setq ns-use-native-fullscreen nil)


;; TODO Don't highlight matches with jump-char - it's distracting
(setq jump-char-lazy-highlight-face nil)

(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Save minibuffer history
(savehist-mode 1)
(setq history-length 1000)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)
;; Keep cursor away from edges when scrolling up/down
(require 'smooth-scrolling)
;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)




;; ;; Display dividers between windows
;; (setq window-divider-default-places t
;;       window-divider-default-bottom-width 1
;;       window-divider-default-right-width 1)
;; (add-hook 'window-setup-hook #'window-divider-mode)


;; (defconst sys/macp
;;   (eq system-type 'darwin)
;;   "Are we running on a Mac system?")


;; (when sys/macp
;;   ;; Render thinner fonts
;;   (setq ns-use-thin-smoothing t)
;;   ;; Don't open a file in a new frame
;;   (setq ns-pop-up-frames nil))

;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)


(which-func-mode 1)


(provide 'init-view)

