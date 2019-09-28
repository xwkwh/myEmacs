
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


(package-initialize)

(load-theme 'spacemacs-dark t)


(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-variables '("PATH"
					 "GOPATH"
					 "GOROOT"
					 "GOBIN"))
  (exec-path-from-shell-initialize))

(require 'init-elpa)        ;; 暂时没用 purcell上烤的
(require 'init-utils)       ;; too
(require 'init-go)          ;; golang相关
(require 'init-view)        ;; 显示相关
(require 'conf-counsel)     ;; 搜索buffer文件
(require 'conf-awesome-tab) ;; tab页
(require 'conf-evil)        ;; vim操作
(require 'init-org)         ;; org mode
(require 'conf-dired)       ;; 文件目录操作
(require 'conf-projectile)
					; (require 'init-themes)


;; 不知道放在哪里的配置
(setq org-startup-indented t)
(setq make-backup-files nil)
;; (setq debug-on-error t)
(scroll-bar-mode -1)
(save-place-mode t)

(setq 
 backup-by-copying t    ;自动备份
 delete-old-versions t ; 自动删除旧的备份文件
 kept-new-versions 10   ; 保留最近的6个备份文件
 kept-old-versions 10   ; 保留最早的2个备份文件
 version-control t    ; 多次备份
 vc-make-backup-files t)

(setq auto-save-visited-interval 30)
(setq auto-save-visited-mode t)
(setq backup-directory-alist '((".*" . "~/.emacs.d/cache/backup_files/")))


(setq custom-file (concat user-emacs-directory "lisp/conf-custom.el"))
(require 'conf-custom)
