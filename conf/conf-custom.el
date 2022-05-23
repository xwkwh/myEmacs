(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#000000" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#eaeaea"))
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/cache/backup_files/" t)))
 '(auto-save-visited-interval 5)
 '(auto-save-visited-mode t)
 '(backup-directory-alist '((".*" . "~/.emacs.d/cache/backup_files/")))
 '(beacon-color "#d54e53")
 '(custom-safe-themes
   '("d2e0c53dbc47b35815315fae5f352afd2c56fa8e69752090990563200daae434" "feb8e98a8a99d78c837ce35e976ebcc97abbd8806507e8970d934bb7694aa6b3" "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" "31f1723fb10ec4b4d2d79b65bcad0a19e03270fe290a3fc4b95886f18e79ac2f" "aca70b555c57572be1b4e4cec57bc0445dcb24920b12fb1fea5f6baa7f2cad02" "bd3b9675010d472170c5d540dded5c3d37d83b7c5414462737b60f44351fb3ed" "0f7fa4835d02a927d7d738a0d2d464c38be079913f9d4aba9c97f054e67b8db9" "88049c35e4a6cedd4437ff6b093230b687d8a1fb65408ef17bfcf9b7338734f6" default))
 '(electric-pair-mode t)
 '(even-window-sizes t)
 '(fci-rule-color "#424242")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(global-auto-revert-mode t)
 '(global-hl-line-mode t)
 '(gofmt-args '("-s" "-d" "-w" "-e"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(kind-icon corfu vundo consult-dir flatbuffers-mode timu-spacegrey-theme slime org-web-tools vterm-toggle use-package org-superstar vterm highlight-parentheses pinyinlib osx-dictionary centaur-tabs orderless marginalia embark-consult embark eglot go-mode all-the-icons-dired consult projectile magit iedit ob-go verb diff-hl evil-search-highlight-persist evil-leader undo-tree yasnippet golden-ratio evil-collection evil flycheck-golangci-lint git-link flycheck rg ox-hugo yaml-mode helpful leetcode protobuf-mode protocols miniedit lua-mode json-mode ox-gfm ivy-prescient company-prescient prescient spaceline-all-the-icons all-the-icons-gnus all-the-icons-ibuffer all-the-icons-ivy-rich neotree doom org-bullets color-theme-sanityinc-tomorrow graphviz-dot-mode smex ccls golden-ratio-scroll-screen dired-narrow scratch elisp-def bm dired-filetype-face diredfl dired-subtree counsel-etags counsel-gtags dumb-jump general vc-msg use-package smooth-scrolling exec-path-from-shell dashboard))
 '(pdf-view-midnight-colors '("#FDF4C1" . "#282828"))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(save-place-file "~/.emacs.d/cache/place")
 '(savehist-file "~/.emacs.d/cache/history")
 '(split-width-threshold 90)
 '(tool-bar-mode nil)
 '(tramp-persistency-file-name "~/.emacs.d/cache/tramp")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-highlight-symbol-face ((t (:inherit (bold highlight)))))
 '(evil-search-highlight-persist-highlight-face ((t (:background "dark cyan"))))
 '(font-lock-done-face ((t (:foreground "Green" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(font-lock-todo-face ((t (:foreground "Red" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(ivy-current-match ((t (:inherit highlight :background "#076678" :foreground "#FDF4C1")))))




(provide 'conf-custom)
