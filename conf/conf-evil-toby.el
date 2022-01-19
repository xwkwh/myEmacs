(require 'evil)

(global-evil-leader-mode)
(setq evil-leader/in-all-states 1)
(evil-leader/set-leader "SPC")

; (require 'evil-search-highlight-persist)
; (global-evil-search-highlight-persist t)

(defun  my-scratch-hook()
  (rename-buffer (concat "scratch" (buffer-name))))
(add-hook 'scratch-create-buffer-hook 'my-scratch-hook)

(provide 'conf-evil-toby)
