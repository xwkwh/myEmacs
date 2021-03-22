(require 'org)

;; Remove the markup characters, i.e., "/text/" becomes (italized) "text"
(setq org-hide-emphasis-markers t)
(setq org-src-fontify-natively t)
;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org-agenda"))

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

(setq show-week-agenda-p t)


;; Turn on visual-line-mode for Org-mode only
;; Also install "adaptive-wrap" from elpa
;; (add-hook 'org-mode-hook 'turn-on-visual-line-mode)
;;

;; (eval-after-load "org"
;;   '(require 'ox-md nil t))

(eval-after-load "org"
  '(require 'ox-gfm nil t))

(with-eval-after-load 'ox
  (require 'ox-hugo))

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

(org-babel-do-load-languages 'org-babel-load-languages
                 '(
                   (shell . t)
                   (emacs-lisp . t)
                   )
                 )
(require 'ob-go)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((go . t)))

 (require 'org-tempo)


;; (use-package general
;;   :init
;;   (defalias 'gsetq #'general-setq)
;;   (defalias 'gsetq-local #'general-setq-local)
;;   (defalias 'gsetq-default #'general-setq-default))



;; (use-package org-agenda
;;   :defer t
;;   :preface
;;   (defun org-agenda-log-mode-colorize-block ()
;;     "Set different line spacing based on clock time duration."
;;     (save-excursion
;;       (let* ((colors (cl-case (alist-get 'background-mode (frame-parameters))
;;                        ('light
;;                         (list "#a7e9af" "#75b79e" "#6a8caf" "#eef9bf"))
;;                        ('dark
;;                         (list "#a7e9af" "#75b79e" "#6a8caf" "#eef9bf"))))
;;              pos
;;              duration)
;;         (nconc colors colors)
;;         (goto-char (point-min))
;;         (while (setq pos (next-single-property-change (point) 'duration))
;;           (goto-char pos)
;;           (when (and (not (equal pos (point-at-eol)))
;;                     (setq duration (org-get-at-bol 'duration)))
;;             ;; larger duration bar height
;;             (let ((line-height (if (< duration 15) 1.0 (+ 0.5 (/ duration 30))))
;;                   (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
;;               (overlay-put ov 'face `(:background ,(car colors) :foreground "black"))
;;               (setq colors (cdr colors))
;;               (overlay-put ov 'line-height line-height)
;;               (overlay-put ov 'line-spacing (1- line-height))))))))
;;   :hook ((org-agenda-finalize . org-agenda-log-mode-colorize-block))
;;   :config
;;   (gsetq-default org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3))
;;   (gsetq
;;    org-agenda-compact-blocks   t
;;    org-agenda-include-diary    nil
;;    org-agenda-span             'week
;;    org-agenda-start-on-weekday nil
;;    org-agenda-start-day       "-1d"
;;    org-agenda-sticky           nil
;;    org-agenda-window-setup     'current-window)

;;   (gsetq
;;    org-agenda-sorting-strategy
;;    '((agenda habit-down time-up user-defined-up effort-up category-keep)
;;      (todo category-up effort-up)
;;      (tags category-up effort-up)
;;      (search category-up)))

;;   (gsetq
;;    org-agenda-time-grid
;;    '((daily today weekly require-timed remove-match)
;;      (0 600 900 1200 1300 1600 1800 2000 2200 2400 2600)
;;      "......"
;;      "-----------------------------------------------------")
;;    org-agenda-prefix-format
;;    '((agenda . " %i %+15c\t%?-15t% s")
;;      (todo   . " %i %+15c\t")
;;      (tags   . " %i %+15c\t")
;;      (search . " %i %+15c\t")))

;;   (after-x 'all-the-icons
;;     (gsetq
     ;; org-agenda-category-icon-alist
     ;; `(("Tasks"        ,(list (all-the-icons-faicon  "tasks"            :height 0.8 :v-adjust 0)) nil nil :ascent center)
     ;;   ("Calendar"     ,(list (all-the-icons-octicon "calendar"         :height 0.8 :v-adjust 0)) nil nil :ascent center)
     ;;   ("Appointments" ,(list (all-the-icons-faicon  "calendar-check-o" :height 0.8 :v-adjust 0)) nil nil :ascent center)))))
;; org-hugo capture

(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* (;; http://www.holgerschurig.de/en/emacs-blog-from-org-to-hugo/
           (date (format-time-string (org-time-stamp-format :long :inactive) (org-current-time)))
           (title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "** TODO " title "     :@随笔:")
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ;; ,(concat ":EXPORT_DATE: " date) ;Enter current date and time
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+headline "~/Dropbox/Write/blog/orgpost/0000-posts.org" "INBOX")
                 (function org-hugo-new-subtree-post-capture-template))))

;; (global-set-key "av" 'org-capture)
;; (global-set-key (kbd "C-c a") 'org-agenda)


(provide 'conf-org-toby)
