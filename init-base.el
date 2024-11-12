;;; Code:

;; ~/.emacs.d/conf/目录加到load-path中
(add-to-list 'load-path (concat user-emacs-directory "conf/"))
(defvar lazy-load-dir (concat user-emacs-directory "lazy"))
(add-to-list 'load-path lazy-load-dir)
(setq submodules-dir (concat user-emacs-directory "submodule"))
(when submodules-dir
  (dolist (dir (directory-files submodules-dir  nil "[a-zA-Z0-9_-]"))
    (add-to-list 'load-path dir)))

(require 'conf-macro)
(require 'conf-tmp-before nil t)


;; (require 'conf-minibuffer)

(setq custom-file (concat user-emacs-directory "conf/conf-custom.el"))
(require 'conf-custom)

(require 'conf-package)
(require 'conf-lazy-load)               ;autoload相关，加快emacs启动速度

(provide 'init-base)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-base.el ends here.
