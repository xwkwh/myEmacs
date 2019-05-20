
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


(package-initialize)



(when (memq window-system '(mac ns x))
(setq exec-path-from-shell-variables '("PATH"
                                       "GOPATH"
                                       "GOROOT"
                                       "GOBIN"))
(exec-path-from-shell-initialize))


(require 'init-go)
(require 'init-view)
(require 'conf-counsel)     ;; 搜索buffer文件
(require 'conf-awesome-tab) ;; tab页
(require 'conf-evil)        ;; vim操作


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (0blayout evil counsel yasnippet company-lsp company-posframe company exec-path-from-shell golint go-eldoc))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
