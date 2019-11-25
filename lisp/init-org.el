
(require 'org)

;; Remove the markup characters, i.e., "/text/" becomes (italized) "text"
(setq org-hide-emphasis-markers t)
(setq org-src-fontify-natively t)
;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)


;; Turn on visual-line-mode for Org-mode only
;; Also install "adaptive-wrap" from elpa
;; (add-hook 'org-mode-hook 'turn-on-visual-line-mode)
;; 

;; (eval-after-load "org"
;;   '(require 'ox-md nil t))

(eval-after-load "org"
  '(require 'ox-gfm nil t))

 ;; (use-package org-bullets
 ;;    :ensure t
 ;;    :config
 ;;    (setq org-bullets-bullet-list '("∙"))
 ;;    (add-hook 'org-mode-hook 'org-bullets-mode))


;; Various preferences
;; (setq org-log-done t
;;       org-edit-timestamp-down-means-later t
;;       org-hide-emphasis-markers t
;;       org-catch-invisible-edits 'show
;;       org-export-coding-system 'utf-8
;;       org-fast-tag-selection-single-key 'expert
;;       org-html-validation-link nil
;;       org-export-kill-product-buffer-when-displayed t
;;       org-tags-column 80)
(setq org-ellipsis "⤵")
(setq org-src-tab-acts-natively t)

(add-hook 'org-mode-hook 'org-bullets-mode)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

(setq  org-todo-keywords
		    '((sequence "TODO(t)" "DOING(i)"  "|" "DONE(d)")
		      (sequence "⚑(T)" "🏴(I)"  "|" "✔(D)" )))


(provide 'init-org)
