
(setq-default  evil-symbol-word-search t )             ;# search for symbol not word
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

(add-to-list 'evil-overriding-maps '(vc-annotate-mode-map . nil))
;; evil-overriding-maps中的按键绑定 优先级高于evil-mode
(add-to-list 'evil-overriding-maps '(vc-git-log-view-mode-map . nil))
(add-to-list 'evil-overriding-maps '(vc-svn-log-view-mode-map . nil))
(add-to-list 'evil-overriding-maps '(vmacs-leader-map . nil))
(add-to-list 'evil-overriding-maps '(custom-mode-map . nil))
(add-to-list 'evil-overriding-maps '(ediff-mode-map . nil))
(add-to-list 'evil-overriding-maps '(package-menu-mode-map . nil))
(add-to-list 'evil-overriding-maps '(minibuffer-local-map . nil))
(add-to-list 'evil-overriding-maps '(minibuffer-local-completion-map . nil))
(add-to-list 'evil-overriding-maps '(minibuffer-local-must-match-map . nil))
(add-to-list 'evil-overriding-maps '(minibuffer-local-isearch-map . nil))
(add-to-list 'evil-overriding-maps '(minibuffer-local-ns-map . nil))
(add-to-list 'evil-overriding-maps '(epa-key-list-mode-map . nil))
(add-to-list 'evil-overriding-maps '(term-mode-map . nil))
(add-to-list 'evil-overriding-maps '(term-raw-map . nil))
(add-to-list 'evil-overriding-maps '(calc-mode-map . nil))
(add-to-list 'evil-overriding-maps '(magit-blob-mode-map . nil)) ;n p 浏览文件历史版本
(add-to-list 'evil-overriding-maps '(org-agenda-mode-map . nil))
(add-to-list 'evil-overriding-maps '(xref--xref-buffer-mode-map . nil))
(add-to-list 'evil-overriding-maps '(snails-mode-map . nil))

(evil-set-custom-state-maps 'evil-overriding-maps
                            'evil-pending-overriding-maps
                            'override-state
                            'evil-make-overriding-map
                            evil-overriding-maps)

;; evil-normalize-keymaps forces an update of all Evil keymaps
(add-hook 'magit-blob-mode-hook #'evil-normalize-keymaps)
;; 更新 evil-overriding-maps ,因为org-agenda-mode-map 变量初始为空keymap,在org-agenda-mode内才往里添加绑定
(add-hook 'org-agenda-mode-hook #'evil-normalize-keymaps)
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



(evil-set-initial-state 'ivy-occur-mode 'normal)
(evil-set-initial-state 'ivy-occur-grep-mode 'normal)



;;  行号magit
;; (setq display-line-numbers-current-absolute t)
(defun vmacs-change-line-number-abs()
  (
   if (member major-mode '( term-mode eshell-mode ansi-term-mode tsmterm-mode magit-status-mode vterm-mode))
   (setq display-line-numbers nil)
   (setq display-line-numbers 'absolute)
   )
  )

(defun vmacs-change-line-number-relative()
  (if (member major-mode '( term-mode eshell-mode ansi-term-mode tsmterm-mode magit-status-mode vterm-mode))
      (setq display-line-numbers nil)
    (setq display-line-numbers 'visual)
    )
  )


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



(evil-escape-mode)
(setq-default evil-escape-key-sequence "jk")





(provide 'conf-evil)
