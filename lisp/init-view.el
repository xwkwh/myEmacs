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
  (setq dashboard-items
        '((recents . 9)
          (bookmarks . 5)
          (projects . 3)
          (agenda . 5))))


;; 隐藏状态栏
(tool-bar-mode -1)

;直接emacs命令打开的窗口相关设置,不要在这里设置字体，否则daemon 启动时字体有可能没创建好，会导致字体设置失败
(setq-default window-system-default-frame-alist                 
              '( 
                    (ns ;; if frame created on mac
                    (height . 0.98)
                    (width . 0.98)
                    (left . 80)
                    (top . 0.2)
                    (alpha . 95)
                    (foreground-color . "#eeeeec")
                    (background-color . "#202020") ;;
                    (background-mode . dark)
                    )))

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

;;;###autoload
(defun create-frame-font-big-mac()          ;emacs 若直接启动 启动时调用此函数似乎无效
  (interactive)
  (set-face-attribute
   'default nil
   :font
   "Menlo 16"
   :fontset "fontset-bigmac"))

(create-frame-font-big-mac)



(provide 'init-view)

