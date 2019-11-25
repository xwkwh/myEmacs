;;; herald-the-mode-line.el --- Underline with a char  -*- lexical-binding: t ; eval: (view-mode 1) -*-

;; THIS FILE HAS BEEN GENERATED.

;; Program
;; :PROPERTIES:
;; :ID:       ba861db4-2828-4294-b2c7-73825b8b57ae
;; :END:


;; [[file:~/emacs-configs/.emacs.d/straight/repos/herald-the-mode-line/herald-the-mode-line.org::*Program][Program:1]]

;;; Commentary:

;; Version: 0.2.0
;; Package-Requires: ((emacs "24"))
;; Keywords: mode-line, convenience

;; Use function herald-the-mode-line to display the mode-line in the
;; minibuffer.  See also buffer *Messages* for the message.

;; This may reveal hidden parts of the mode-line.  The latter occurs
;; when the mode-line is too long.  Or when hidden-mode-line-mode is
;; active (see https://emacs-doctor.com/emacs-hide-mode-line.html.)

;; One user recommends to bind the function to a key.


;;; Code:


;;;###autoload
(defun herald-the-mode-line ()
  "Show the modeline in the minibuffer.
Use case: when the modeline is to short for its content this
command reveals the other lines."
  (interactive)
  (message
   "%s"
   (format-mode-line
    (or mode-line-format
        ;; {{{ a little hack to go together with hidden-mode-line-mode.
        ;;
        (when (and (boundp 'hidden-mode-line-mode) hidden-mode-line-mode)
                                        ; this is supposed to be the mode line
                                        ; format hidden via hidden-mode-line-mode.
          hide-mode-line)
        ;; }}}
        ))))


(provide 'herald-the-mode-line)
;; Program:1 ends here


;;; herald-the-mode-line.el ends here
