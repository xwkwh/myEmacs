(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-visited-interval 30)
 '(auto-save-visited-mode t)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(electric-pair-mode t)
 '(package-selected-packages
   (quote
    (ivy-posframe doom-themes hc-zenburn-theme zenburn-theme monokai-pro-theme monokai-theme material-theme wakatime-mode smex vterm-toggle vterm ibuffer-projectile projectile fullframe seq wgrep iedit evil-magit powerline-evil magit dired-narrow ivy-dired-history evil-search-highlight-persist evil-leader json-mode lua-mode dashboard atom-one-dark-theme spacemacs-theme magit-org-todos 0blayout evil counsel yasnippet company-lsp company-posframe company exec-path-from-shell golint go-eldoc)))
 '(save-place-file "~/.emacs.d/cache/place")
 '(savehist-file "~/.emacs.d/cache/history")
 '(tramp-persistency-file-name "~/.emacs.d/cache/tramp"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-search-highlight-persist-highlight-face ((t (:background "dark cyan"))))
 '(font-lock-done-face ((t (:foreground "Green" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(font-lock-todo-face ((t (:foreground "Red" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(powerline-evil-normal-face ((t (:inherit default :background "dark green")))))

(provide 'conf-custom)
