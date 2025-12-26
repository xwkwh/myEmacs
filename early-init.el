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
(set-default-toplevel-value 'lexical-binding t)
(defconst my/start-time (current-time))


(defmacro mt (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f" (float-time (time-since time)))))

(defvar file-name-handler-alist-old file-name-handler-alist)

(setq file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum   ;; Defer Garbage collection
      gc-cons-percentage 1.0)

(add-hook 'window-setup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old
                  gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)
            (garbage-collect)
            (message "Load time %.06f" (float-time (time-since my/start-time))))
          t)


(setq load-prefer-newer t)              ;当 el 文件比 elc 文件新的时候,则加载 el,即尽量 Load 最新文件文件
;; By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
;; If we increase this to 20 MB (gc-cons-threshold == 20000000) we get:
(setq read-process-output-max (* 3 1024 1024)) ;; 3mb default 4k

;; 禁用工具栏，滚运条 菜单栏
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq-default default-frame-alist initial-frame-alist)

(setq-default mode-line-format nil)
(setq mode-line-format nil)
(setq modus-themes-hl-line  '(intense accented))
(load  (concat user-emacs-directory "init-base.el"))
(when (eq system-type 'darwin) (require 'conf-macos))
(when (eq system-type 'gnu/linux) (require 'conf-linux))
(when (eq system-type 'windows-nt) (require 'conf-w32))
