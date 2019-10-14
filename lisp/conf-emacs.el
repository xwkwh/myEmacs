;; 不知道放在哪里的配置
(setq org-startup-indented t)
(setq make-backup-files nil)
;; (setq debug-on-error t)
(scroll-bar-mode -1)
(save-place-mode t)
(global-auto-revert-mode t)
(setq recentf-max-saved-items 300)

;; vendor 不需修改
(defun find-file-vendor-read-only ()
  (when (string-match "/vendor/" (buffer-file-name))
    (read-only-mode 1)
    )
  )

(add-hook 'find-file-hooks 'find-file-vendor-read-only) ;;

  

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

(fset 'yes-or-no-p 'y-or-n-p) ;; 把Yes用y代替
(provide 'conf-emacs)
