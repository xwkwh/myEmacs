;; 不知道放在哪里的配置
(setq org-startup-indented t)
;; (setq make-backup-files nil)
;; (setq debug-on-error t)
;; (scroll-bar-mode -1)
;; (global-auto-revert-mode t)

;; vendor 不需修改
;; (defun find-file-vendor-read-only ()
;;   (when (string-match "/vendor/" (buffer-file-name))
;;     (read-only-mode 1)
;;     )
;;   )

;; (add-hook 'find-file-hooks 'find-file-vendor-read-only) ;;


;; (flymake-mode -1)
(provide 'conf-emacs)
