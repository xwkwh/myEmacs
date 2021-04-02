;; (require 'evil-magit)                   ;


;; (evil-define-key evil-magit-state magit-mode-map "q" 'my/quit-magit-buffer)

(defun my/quit-magit-buffer()
  (interactive)
	  (magit-mode-bury-buffer t)
                  )


(setq-default
 magit-status-margin '(t age magit-log-margin-width t 10) ;magit-status 中的Recent commits列表有没有办法增加作者列
 ;; slow ,if t
 magit-diff-refine-hunk nil  ;'all, This is super useful when only a single identifier/word is changed all over the place
 magit-diff-show-diffstat nil
 magit-diff-highlight-hunk-body nil
 magit-log-arguments  '("-n256" "--graph" "--decorate" "--follow") ;加了--follow ,rename的log也能看到
 magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1
 magit-diff-section-arguments '("--ignore-space-at-eol" "--ignore-blank-lines" "--no-ext-diff") ;do not set this ;use  toggle-diff-whitespace-eol to toggle
 magit-section-highlight-hook nil       ;不必hightlight,光标移动的时候，默认会显示当前section区域
 magit-section-unhighlight-hook nil)                         ;


(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)

;; move cursor into position when entering commit message
(defun my/magit-cursor-fix ()
  (beginning-of-buffer)
  (when (looking-at "#")
    (forward-line 2)))

(add-hook 'git-commit-mode-hook 'my/magit-cursor-fix)




;; full screen vc-annotate
(defun vc-annotate-quit ()
  "Restores the previous window configuration and kills the vc-annotate buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :vc-annotate-fullscreen))

(with-eval-after-load "vc-annotate"
     (defadvice vc-annotate (around fullscreen activate)
       (window-configuration-to-register :vc-annotate-fullscreen)
       ad-do-it
       (delete-other-windows))
     (define-key vc-annotate-mode-map (kbd "q") 'vc-annotate-quit)
     (define-key vc-annotate-mode-map (kbd "j") nil)
     )
(set-default 'magit-diff-refine-hunk t)

;; update diff-hl

(global-diff-hl-mode)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)




;; don't prompt me
(set-default 'magit-push-always-verify nil)
(set-default 'magit-revert-buffers 'silent)
(set-default 'magit-no-confirm '(stage-all-changes
                                 unstage-all-changes))
;; expand sections by default
(setq magit-section-initial-visibility-alist
      '((untracked . show)
        (unstaged . show)
        (unpushed . show)
        (unpulled . show)
        (stashes . show)))

(provide 'conf-git)
