;;; Code:

;; ;; 兼容性：set-local 是 Emacs 30+ 的函数，旧版或部分开发版没有
;; (unless (fboundp 'set-local)
;;   (defun set-local (variable value)
;;     (set (make-local-variable variable) value)))

; ~/.emacs.d/conf/目录加到load-path中
(add-to-list 'load-path (concat user-emacs-directory "conf/"))
(defvar lazy-load-dir (concat user-emacs-directory "lazy"))
(add-to-list 'load-path lazy-load-dir)
(setq submodules-dir (concat user-emacs-directory "submodule"))
(when submodules-dir
  (dolist (dir (directory-files submodules-dir  nil "[a-zA-Z0-9_-]"))
    (add-to-list 'load-path (expand-file-name dir  submodules-dir))))


(require 'conf-macro)
(require 'conf-tmp-before nil t)



(setq custom-file (concat user-emacs-directory "conf/conf-custom.el"))
(require 'conf-custom)

(require 'conf-package)
(require 'conf-lazy-load)               ;autoload相关，加快emacs启动速度

(setq package-install-upgrade-built-in t)
;; 抑制后台原生编译（Native Compilation）无意义的警告弹窗
(setq native-comp-async-report-warnings-errors nil)
(setq comp-async-report-warnings-errors nil)
(setq warning-minimum-level :error)

(provide 'init-base)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-base.el ends here.
