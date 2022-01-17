(require 'package)
  ;; (setq package-archives
  ;;       '(("melpa-cn" . "http://mirrors.163.com/elpa/melpa/")
  ;;         ("nognu-cn" . "http://mirrors.163.com/elpa/nongnu/")
  ;;         ("gnu-cn"   . "http://mirrors.163.com/elpa/gnu/")))
;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;           ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; (setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
;;          ("org"  .  "http://mirrors.cloud.tencent.com/elpa/org/")
;;                           ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "127.0.0.1:12639")))

(setq package-archives
      '(("melpa-cn" .  "http://melpa.org/packages/")
        ("nognu-cn" .  "http://elpa.nongnu.org/nongnu/")
        ("gnu-cn"   .  "http://elpa.gnu.org/packages/")))


(or (file-exists-p package-user-dir) (package-refresh-contents))
;; (package-initialize)

(defun ensure-package-installed (packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))


(add-hook 'after-init-hook (lambda() (ensure-package-installed package-selected-packages)))


;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "127.0.0.1:12639")))


(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))

(provide 'conf-package)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-common.el ends here.
