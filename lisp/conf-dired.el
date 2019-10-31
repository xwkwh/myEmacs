

(require 'savehist)
(add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
(savehist-mode 1)


(require 'ivy-dired-history)


(define-key dired-mode-map "," 'dired)  ;;


(define-key dired-mode-map "u" 'dired-up-directory) ;上层目录

(define-key dired-mode-map  "/" 'dired-narrow) ;dired-narrow-fuzzy
(define-key dired-mode-map  (kbd "C-s") 'dired-narrow) ;dired-narrow-fuzzyxs


(require 'dired-single)
;; // 单个buffer
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-dwim-target t)

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
    (define-key dired-mode-map (kbd "u") (lambda () (interactive) (find-alternate-file ".."))))  ; was dired-up-directory)


(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)
(setq ls-lisp-verbosity nil)

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


(provide 'conf-dired)
