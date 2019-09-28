(require 'evil)
(evil-mode)
(setq-default
 evil-default-cursor '(t "white")
 evil-emacs-state-cursor  '("gray" box)
 evil-normal-state-cursor '("green" box)
 evil-visual-state-cursor '("cyan" hbar)
 evil-insert-state-cursor '("orange" (bar . 3))
 evil-motion-state-cursor '("red" box))


(global-evil-leader-mode)
(setq evil-leader/in-all-states 1)
(evil-leader/set-leader "SPC")

(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
(evil-leader/set-key "b" 'evil-search-highlight-persist-remove-all)
(evil-leader/set-key "SPC"   'ivy-switch-buffer)
(autoload 'dired-jump "dired-x" "dired-jump" t)
(evil-leader/set-key "j" 'dired-jump)
(evil-leader/set-key "s" 'evil-write-all)
(evil-leader/set-key  "ff" 'counsel-find-file)
(evil-leader/set-key  "ft" #'(lambda()(interactive)(let ((default-directory "/tmp/"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key  "fh" #'(lambda()(interactive)(let ((default-directory "~"))(call-interactively 'counsel-find-file))))






(provide 'conf-evil)
