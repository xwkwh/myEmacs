(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#000000" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#eaeaea"))
 '(beacon-color "#d54e53")
 '(custom-safe-themes
   (quote
    ("88049c35e4a6cedd4437ff6b093230b687d8a1fb65408ef17bfcf9b7338734f6" default)))
 '(electric-pair-mode t)
 '(fci-rule-color "#424242")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(menu-bar-mode nil)
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (miniedit lua-mode json-mode ox-gfm ivy-prescient company-prescient prescient zenburn-theme spaceline-all-the-icons all-the-icons-gnus all-the-icons-ibuffer all-the-icons-ivy-rich neotree doom-modeline doom org-bullets color-theme-sanityinc-tomorrow graphviz-dot-mode smex ccls golden-ratio-scroll-screen dired-narrow scratch elisp-def bm dired-filetype-face diredfl dired-subtree counsel-etags counsel-gtags dumb-jump general vc-msg menu-bar-mode nil)))
 '(pdf-view-midnight-colors (quote ("#FDF4C1" . "#282828")))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(save-place-file "~/.emacs.d/cache/place")
 '(savehist-file "~/.emacs.d/cache/history")
 '(split-width-threshold 90)
 '(tool-bar-mode nil)
 '(tramp-persistency-file-name "~/.emacs.d/cache/tramp")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
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
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-search-highlight-persist-highlight-face ((t (:background "dark cyan"))))
 '(font-lock-done-face ((t (:foreground "Green" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(font-lock-todo-face ((t (:foreground "Red" :box (:line-width 2 :color "grey75" :style released-button) :height 1.2))) t)
 '(ivy-current-match ((t (:inherit highlight :background "#076678" :foreground "#FDF4C1"))))
 '(powerline-evil-normal-face ((t (:inherit default :background "dark green")))))




(provide 'conf-custom)
