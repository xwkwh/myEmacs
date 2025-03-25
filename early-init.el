;; __   ___ __ ___   __ _  ___ ___
;; \ \ / / '_ ` _ \ / _` |/ __/ __|
;;  \ V /| | | | | | (_| | (__\__ \
;;   \_/ |_| |_| |_|\__,_|\___|___/
;; |aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa|
;; |你你你你你你你你你你你你你你你你你你你你|
;; |,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,|
;; |。。。。。。。。。。。。。。。。。。。。|
;; |1111111111111111111111111111111111111111|
;; |東東東東東東東東東東東東東東東東東東東東|
;; |😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀|
;; |ここここここここここここここここここここ|
;; |ｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺｺ|
;; |까까까까까까까까까까까까까까까까까까까까|

(defconst my/start-time (current-time))

;; 临时禁用调试工具（移除 `mt` 宏)
(setq load-prefer-newer t
      message-log-max 16384
      gc-cons-threshold (* 400 1024 1024)    ; 400MB（平衡内存与启动速度）
      gc-cons-percentage 0.6
      read-process-output-max (* 3 1024 1024))


;; ==== UI 配置 ====
;; 禁用非必要组件
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode 0))

(defvar file-name-handler-alist-old file-name-handler-alist)

;; ==== GC 恢复 ====
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)  ; 恢复为 16MB
                  gc-cons-percentage 0.1
                  file-name-handler-alist file-name-handler-alist-old)

            (garbage-collect)
            (message "Load time %.06f" (float-time (time-since my/start-time)))
            (message "Emacs ready in %.2fs (RAM: %.2fMB)"
                     (float-time (time-since my/start-time))
                     (/ (car (memory-usage)) 1024.0 1024.0))))

;; ========================================================
;; ========================================================

(defmacro mt (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f" (float-time (time-since time)))))

(setq load-prefer-newer t)              ;当 el 文件比 elc 文件新的时候,则加载 el,即尽量 Load 最新文件文件
;; By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
;; If we increase this to 20 MB (gc-cons-threshold == 20000000) we get:
(setq read-process-output-max (* 3 1024 1024)) ;; 3mb default 4k


(setq-default default-frame-alist initial-frame-alist)

(setq-default mode-line-format nil)
(setq mode-line-format nil)
(setq modus-themes-hl-line  '(intense accented))

(load-file "~/.emacs.d/init-base.el")
(when (eq system-type 'darwin) (require 'conf-macos))
(when (eq system-type 'gnu/linux) (require 'conf-linux))
(when (eq system-type 'windows-nt) (require 'conf-w32))
