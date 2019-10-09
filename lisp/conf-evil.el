
(require 'evil)

(evil-set-initial-state 'vterm-mode 'insert)
(evil-set-initial-state 'bm-show-mode 'insert)
(evil-set-initial-state 'diff-mode 'normal)
(evil-set-initial-state 'git-rebase-mode 'normal)
(evil-set-initial-state 'package-menu-mode 'normal)
(evil-set-initial-state 'vc-annotate-mode 'normal)
(evil-set-initial-state 'Custom-mode 'normal)
(evil-set-initial-state 'erc-mode 'normal)
(evil-set-initial-state 'ibuffer-mode 'normal)
(evil-set-initial-state 'vc-dir-mode 'normal)
(evil-set-initial-state 'vc-git-log-view-mode 'normal)
(evil-set-initial-state 'vc-svn-log-view-mode 'normal)
;; (evil-set-initial-state 'erlang-shell-mode 'normal)
(evil-set-initial-state 'org-agenda-mode 'normal)
(evil-set-initial-state 'minibuffer-inactive-mode 'normal)
(evil-set-initial-state 'ivy-occur-mode 'normal)
(evil-set-initial-state 'ivy-occur-grep-mode 'normal)
(evil-set-initial-state 'grep-mode 'normal)
(evil-set-initial-state 'Info-mode 'motion)


(evil-mode)
(setq-default
 evil-default-cursor '(t "white")
 evil-emacs-state-cursor  '("gray" box)
 evil-normal-state-cursor '("cyan" box)
 evil-visual-state-cursor '("cyan" hbar)
 evil-insert-state-cursor '("orange" (bar . 3))
 evil-motion-state-cursor '("red" box))


(global-evil-leader-mode)
(setq evil-leader/in-all-states 1)
(evil-leader/set-leader "SPC")

(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)

(require 'powerline)
;; (powerline-evil-vim-color-theme)  
;; (display-time-mode t)

(require 'powerline-evil)
(set-face-attribute 'powerline-evil-normal-face nil :background "dark green")


(evil-set-initial-state 'ivy-occur-mode 'normal)
(evil-set-initial-state 'ivy-occur-grep-mode 'normal)



;;  行号magit
;; (setq display-line-numbers-current-absolute t)
(defun vmacs-change-line-number-abs()
  (if (member major-mode '( term-mode eshell-mode ansi-term-mode tsmterm-mode magit-status-mode vterm-mode))
      (setq display-line-numbers nil)
    (setq display-line-numbers 'absolute)))

(defun vmacs-change-line-number-relative()
  (if (member major-mode '( term-mode eshell-mode ansi-term-mode tsmterm-mode magit-status-mode vterm-mode))
      (setq display-line-numbers nil)
    (setq display-line-numbers 'visual)))


(add-hook 'evil-insert-state-entry-hook 'vmacs-change-line-number-abs)
(add-hook 'evil-normal-state-entry-hook 'vmacs-change-line-number-relative)
(add-hook 'evil-motion-state-entry-hook 'vmacs-change-line-number-relative)



;;;;

;;wgrep
;; (add-hook 'grep-setup-hook 'grep-mode-fun)
(setq-default wgrep-auto-save-buffer nil ;真正的打开文件，会处理各种find-file save-file的hook,慢，如gofmt引入package
              wgrep-too-many-file-length 1
              ;; wgrep-enable-key "i"
              wgrep-change-readonly-file t)

(defun vmacs-wgrep-finish-edit()
  (interactive)
  (if  current-prefix-arg
      (let ((wgrep-auto-save-buffer t))
        (call-interactively #'wgrep-finish-edit)
        )
    (call-interactively #'wgrep-finish-edit)
    (let ((count 0))
      (dolist (b (buffer-list))
        (with-current-buffer b
          (when (buffer-file-name)
            (let ((ovs (wgrep-file-overlays)))
              (when (and ovs (buffer-modified-p))
                (basic-save-buffer)
                (kill-this-buffer)
                (setq count (1+ count)))))))
      (cond
       ((= count 0)
        (message "No buffer has been saved."))
       ((= count 1)
        (message "Buffer has been saved."))
       (t
        (message "%d buffers have been saved." count))))))

(with-eval-after-load 'wgrep
  (define-key wgrep-mode-map (kbd "C-g") 'wgrep-abort-changes)
  (define-key wgrep-mode-map (kbd "C-c C-c") 'vmacs-wgrep-finish-edit))

(defun enable-wgrep-when-entry-insert()
  (when (derived-mode-p 'ivy-occur-mode
                        'ivy-occur-grep-mode 'helm-grep-mode)
    (wgrep-change-to-wgrep-mode)))
(add-hook 'evil-insert-state-entry-hook 'enable-wgrep-when-entry-insert)




;;;;  窗口最大

(setq display-buffer-alist
      '(
        ("^v?term.*"
         (display-buffer-pop-up-window)
         ;; (inhibit-same-window . t)
         ;; (reusable-frames . nil)
         (side . bottom)
         ;; (window-height . 1)
         )
        ("\\*ivy-occur.*"
         (display-buffer-same-window ))
        ;; default
        ;; (".*" (display-buffer-pop-up-window))
        ))


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;test;;;;;;;;;;;;;

(defun my-line-theme ()
  "Powerline's Vim-like mode-line with evil state at the beginning in color."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (powerline-raw (powerline-evil-tag) evil-face)))
                                     (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-major-mode mode-line)
                                     (powerline-process mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (buffer-modified-p)
                                       (powerline-raw "[+]" mode-line))
                                     (when buffer-read-only
                                       (powerline-raw "[RO]" mode-line))
                                     (powerline-raw "[%z]" mode-line)
                                     ;; (powerline-raw (concat "[" (mode-line-eol-desc) "]") mode-line)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-minor-modes mode-line)
                                     (powerline-raw "%n" mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (and vc-mode buffer-file-name)
                                       (let ((backend (vc-backend buffer-file-name)))
                                         (when backend
                                           (concat (powerline-raw "[" mode-line 'l)
                                                   (powerline-raw (format "%s / %s" backend (vc-working-revision buffer-file-name backend)))
                                                   (powerline-raw "]" mode-line)))))))
                          (rhs (list (powerline-raw '(10 "%i"))
                                     (powerline-raw global-mode-string mode-line 'r)
                                     (powerline-raw "%l," mode-line 'l)
                                     (powerline-raw (format-mode-line '(10 "%c")))
                                     (powerline-raw (replace-regexp-in-string  "%" "%%" (format-mode-line '(-3 "%p"))) mode-line 'r))))
                     (concat (powerline-render lhs)
                             (powerline-fill mode-line (powerline-width rhs))
                             (powerline-render rhs)))))))


(my-line-theme)

;;; 自定义 mode line
(setq-default mode-line-format '(
				 "%e"
				 (:eval
				  (window-numbering-get-number-string))
				 ;; mode-line-front-space
				 ;; mode-line-mule-info
				 ;; mode-line-client
				 ;; mode-line-modified -- show buffer change or not
				 ;; mode-line-remote -- no need to indicate this specially
				 ;; mode-line-frame-identification -- this is for text-mode emacs only
				 ;; "["
				 ;; mode-name
				 ;; ":"
				 ;; mode-line-buffer-identification
				 "%f"
				 ;; "]"
				 " "
				 mode-line-position
				 (vc-mode vc-mode)
				 " "
				 ;; mode-line-modes -- move major-name above
				 ;; "["
				 ;; minor-mode-alist
				 ;; "]"
				 ;; mode-line-misc-info
				 ;; mode-line-end-spaces
				 ))




(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "red")









(provide 'conf-evil)
