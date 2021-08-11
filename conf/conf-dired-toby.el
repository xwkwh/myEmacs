;; (require 'ivy-dired-history)


;; (define-key dired-mode-map "," 'dired)  ;;

;; dired 目录排序
(defun custom-dired-sort-dir-first ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil)
  )
(add-hook 'dired-after-readin-hook 'custom-dired-sort-dir-first)

(use-package dired-subtree
  :defer t
  :bind (:map dired-mode-map
              ("TAB" . dired-subtree-cycle)))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


(provide 'conf-dired-toby)
