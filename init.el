;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


(package-initialize)


(require 'init-elpa)        ;; 暂时没用 purcell上烤的
(require 'init-utils)       ;; too
(require 'init-view)        ;; 显示相关
(require 'conf-modeline)
(require 'init-go)          ;; golang相关
(require 'conf-counsel)     ;; 搜索buffer文件
(require 'conf-awesome-tab) ;; tab页
(require 'conf-ivy)         ;; ivy
(require 'conf-evil)        ;; vim操作
(require 'conf-evil-symbol)
(require 'init-org)         ;; org mode
(require 'conf-dired)       ;; 文件目录操作
(require 'conf-projectile)
(require 'conf-git)         ;; git 版本控制 magit的配置
(require 'conf-iedit)
(require 'conf-keybind)     ;; 键位绑定
;; (require 'init-themes)

(require 'conf-emacs) ;; emacs 的其他配置


(require 'conf-custom)
(put 'dired-find-alternate-file 'disabled nil)
