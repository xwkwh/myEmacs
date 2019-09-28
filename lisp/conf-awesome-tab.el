(require 'awesome-tab) 
(setq-default awesome-tab-cycle-scope 'tabs)
(setq-default awesome-tab-display-sticky-function-name nil)
(setq-default awesometab-hide-tabs-hooks   nil)
(setq-default awesome-tab-style "zigzag")
(global-set-key  (kbd "s-n") 'awesome-tab-forward)
(global-set-key  (kbd "s-p") 'awesome-tab-backward)
(setq awesome-tab-buffer-groups-function 'vmacs-awesome-tab-buffer-groups)

(defun vmacs-awesome-tab-buffer-groups ()
  "`awesome-tab-buffer-groups' control buffers' group rules.
    Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `projectile-project-p' with project name."
  (list
   (cond
    ((or (string-match-p "\\*scratch-.*" (buffer-name))
         (derived-mode-p 'eshell-mode 'term-mode 'shell-mode 'vterm-mode))
     "Term")
    ((string-match-p (rx (or
                          "\*Helm"
                          "\*helm"
                          "\*Flymake log\*"
                          "\*Help\*"
			  "\*go-bingo"
                          "\*gopls::stderr\*"
                          "\*gopls\*"
                          "\*sdcv\*"
                          "\*tramp"
                          "\*lsp-log\*"
                          "\*tramp"
                          "\*ccls"
                          "\*vc"
                          "\*xref"
                          "\*Completions\*"
                          "\*Warnings*"
                          "magit-"
                          "\*Async Shell Command\*"
                          "\*Shell Command Output\*"
                          "\*Flycheck error messages\*"
                          "\*Gofmt Errors\*"
                          "\*sdcv\*"
                          "\*Messages\*"
                          "\*Ido Completions\*"
                          ))
                     (buffer-name))
     "Emacs")
    ((not (vmacs-show-tabbar-p)) nil)
    (t "Common"))))
(defun vmacs-show-tabbar-p(&optional buf redisplay)
  (let ((show t))
    (with-current-buffer (or buf (current-buffer))
      (cond
       ((char-equal ?\  (aref (buffer-name) 0))
        (setq show nil))
       ((member (buffer-name) '("*Ediff Control Panel*"
                                "\*Flycheck error messages\*"
                                "\*Gofmt Errors\*"))
        (setq show nil))
       (t t))
      (unless show
        ;; (kill-local-variable 'header-line-format)
        (setq header-line-format nil)
        (when redisplay (redisplay t))
        )
      show)))

(defun vmacs-hide-tab-p(buf)
  (not (vmacs-show-tabbar-p buf t)))

(setq awesome-tab-hide-tab-function #'vmacs-hide-tab-p)

(setq awesome-tab-label-fixed-length 30)


(awesome-tab-mode t)


(provide 'conf-awesome-tab)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-awesome-tab.el ends here.
