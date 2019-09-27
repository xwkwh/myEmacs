

(require 'savehist)
(add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
(savehist-mode 1)


(require 'ivy-dired-history)


(define-key dired-mode-map "," 'dired)  ;;


(define-key dired-mode-map "u" 'dired-up-directory) ;上层目录

(define-key dired-mode-map  "/" 'dired-narrow) ;dired-narrow-fuzzy
(define-key dired-mode-map  (kbd "C-s") 'dired-narrow) ;dired-narrow-fuzzyxs

(provide 'conf-dired)
