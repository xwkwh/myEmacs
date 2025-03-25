;; 自动同步远程服务器的 PATH 环境变量

(require 'tramp)

(setq vterm-tramp-shells
      '(("ssh" "/bin/zsh -il") ; 直接调用交互式登录shell
        ("scp" "/bin/zsh -il")
        ("docker" "/bin/sh")))



(setq consult-buffer-filter
      (remove "\\`\\*tramp/.*\\*\\'" consult-buffer-filter))


(add-hook 'after-init-hook
          (lambda ()
            (message "Recentf 列表内容: %s" recentf-list)))


(provide 'conf-tramp)
