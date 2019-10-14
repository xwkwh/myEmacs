
(require 'org)

;; Remove the markup characters, i.e., "/text/" becomes (italized) "text"
(setq org-hide-emphasis-markers t)

;; Turn on visual-line-mode for Org-mode only
;; Also install "adaptive-wrap" from elpa
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)


(eval-after-load "org"
  '(require 'ox-md nil t))


 (use-package org-bullets
    :ensure t
    :config
    (setq org-bullets-bullet-list '("∙"))
    (add-hook 'org-mode-hook 'org-bullets-mode))


;; Various preferences
(setq org-log-done t
      org-edit-timestamp-down-means-later t
      org-hide-emphasis-markers t
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


(provide 'init-org)
