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
 '(connection-local-criteria-alist
   '(((:application vc-git) vc-git-connection-default-profile)
     ((:application tramp :protocol "kubernetes") tramp-kubernetes-connection-local-default-profile)
     ((:application eshell) eshell-connection-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile
      tramp-flatpak-connection-local-default-profile)
     ((:application tramp :machine "localhost") tramp-connection-local-darwin-ps-profile)
     ((:application tramp :machine "MacBook-Pro.local") tramp-connection-local-darwin-ps-profile)
     ((:application tramp) tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((vc-git-connection-default-profile (vc-git--program-version))
     (tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin"
                         "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin"
                         "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin"
                         "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97 (tramp-kubernetes--container (car tramp-current-connection)) 104
                               (tramp-kubernetes--pod (car tramp-current-connection)) 120
                               (tramp-kubernetes--context-namespace (car tramp-current-connection))))
     (eshell-connection-default-profile (eshell-path-env-list))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin"
                         "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin"
                         "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin"
                         "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "state=abcde" "-o"
                                        "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number) (user . string)
                                          (egid . number) (comm . 52) (state . 5) (ppid . number)
                                          (pgrp . number) (sess . number) (ttname . string)
                                          (tpgid . number) (minflt . number) (majflt . number)
                                          (time . tramp-ps-time) (pri . number) (nice . number)
                                          (vsize . number) (rss . number) (etime . tramp-ps-time)
                                          (pcpu . number) (pmem . number) (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o"
                                        "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format (pid . number) (user . string) (group . string)
                                          (comm . 52) (state . 5) (ppid . number) (pgrp . number)
                                          (ttname . string) (time . tramp-ps-time) (nice . number)
                                          (etime . tramp-ps-time) (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o"
                                        "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number) (user . string)
                                          (egid . number) (group . string) (comm . 52)
                                          (state . string) (ppid . number) (pgrp . number)
                                          (sess . number) (ttname . string) (tpgid . number)
                                          (minflt . number) (majflt . number) (time . tramp-ps-time)
                                          (pri . number) (nice . number) (vsize . number)
                                          (rss . number) (etime . number) (pcpu . number)
                                          (pmem . number) (args)))
     (tramp-connection-local-default-shell-profile (shell-file-name . "/bin/sh")
                                                   (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile (path-separator . ":")
                                                    (null-device . "/dev/null"))))
 '(custom-safe-themes
   '("d2e0c53dbc47b35815315fae5f352afd2c56fa8e69752090990563200daae434"
     "feb8e98a8a99d78c837ce35e976ebcc97abbd8806507e8970d934bb7694aa6b3"
     "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a"
     "31f1723fb10ec4b4d2d79b65bcad0a19e03270fe290a3fc4b95886f18e79ac2f"
     "aca70b555c57572be1b4e4cec57bc0445dcb24920b12fb1fea5f6baa7f2cad02"
     "bd3b9675010d472170c5d540dded5c3d37d83b7c5414462737b60f44351fb3ed"
     "0f7fa4835d02a927d7d738a0d2d464c38be079913f9d4aba9c97f054e67b8db9"
     "88049c35e4a6cedd4437ff6b093230b687d8a1fb65408ef17bfcf9b7338734f6" default))
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
   '(0blayout blacken blamer bm cape centaur-tabs chatgpt-shell color-theme-sanityinc-tomorrow
              company-prescient conda consult-dir consult-flycheck corfu counsel-etags counsel-gtags
              dashboard diff-hl dired-filetype-face dired-narrow dired-subtree diredfl
              dockerfile-mode doom dumb-jump editorconfig elisp-def embark-consult evil-collection
              evil-leader evil-search-highlight-persist exec-path-from-shell flatbuffers-mode
              flycheck-golangci-lint general git-link go-mode golden-ratio
              golden-ratio-scroll-screen gptai graphviz-dot-mode helpful highlight-parentheses iedit
              ivy-prescient ivy-rich json-mode kind-icon leetcode lsp-pyright lua-mode magit
              marginalia meow miniedit neotree ob-go orderless org-bullets org-make-toc
              org-superstar org-web-tools osx-dictionary ox-gfm ox-hugo pinyinlib projectile
              protobuf-mode protocols pylint pyvenv rg scratch slime smex smooth-scrolling
              timu-spacegrey-theme undo-tree use-package vc-msg verb vterm vterm-toggle vundo
              yaml-mode yasnippet))
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
   '((20 . "#d54e53") (40 . "#e78c45") (60 . "#e7c547") (80 . "#b9ca4a") (100 . "#70c0b1")
     (120 . "#7aa6da") (140 . "#c397d8") (160 . "#d54e53") (180 . "#e78c45") (200 . "#e7c547")
     (220 . "#b9ca4a") (240 . "#70c0b1") (260 . "#7aa6da") (280 . "#c397d8") (300 . "#d54e53")
     (320 . "#e78c45") (340 . "#e7c547") (360 . "#b9ca4a")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-log-types
   '(((flymake flymake.el)) (initialization) (initialization) (initialization) (comp) (comp) (comp)
     (comp) (comp) (comp) (comp) (comp) (comp)))
 '(warning-suppress-types
   '((initialization) (initialization) (initialization) (comp) (comp) (comp) (comp) (comp) (comp)
     (comp) (comp) (comp)))
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
