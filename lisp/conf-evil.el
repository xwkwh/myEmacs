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


(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)


(provide 'conf-evil)
