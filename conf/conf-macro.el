;;; -*- lexical-binding: t; -*-

(defvar vmacs-leader-mode-map (make-sparse-keymap) "High precedence keymap.")
(defvar vmacs-space-leader-mode-map (make-sparse-keymap) "High precedence keymap.")

(define-minor-mode vmacs-leader-mode "Global minor mode for higher precedence evil keybindings." :global t)
(vmacs-leader-mode)

(with-eval-after-load 'evil
  (dolist (state '(normal visual insert))
    (evil-make-intercept-map
     ;; NOTE: This requires an evil version from 2018-03-20 or later
     (evil-get-auxiliary-keymap vmacs-leader-mode-map state t t)
     state))
  (evil-define-key '(normal visual operator motion emacs) vmacs-leader-mode-map " " vmacs-space-leader-mode-map))

(defmacro vmacs-leader (key cmd)
  `(define-key vmacs-space-leader-mode-map (kbd ,key) ,cmd))


(defmacro vmacs-defun (fun-name &rest body)
  (declare (indent defun)
           (doc-string 3))
  (let ((fun (intern (format "%s" fun-name))))
    `(defun ,fun()
       (interactive)
       ,@body)))

(provide 'conf-macro)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-macro.el ends here.
