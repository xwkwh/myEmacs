(load "~/.emacs.d/init-base.el")
(when (< emacs-major-version 27) (package-initialize))
(when (member system-type '(gnu/linux darwin)) (require 'conf-sudo))
(require 'conf-space-tab)
(eval-after-load 'ibuffer '(require 'conf-ibuffer)) ;绑定在space l 上，用于列出当前打开的哪些文件
(require 'conf-evil) ;; evil jixiuf
;; mac 上处理evil-mode 与中文输入法
(require 'conf-evil-window)       ;窗口

(when (eq system-type 'darwin) (require 'conf-macos))
(with-eval-after-load 'iedit (require 'conf-iedit))
(require 'conf-common)
(with-eval-after-load 'org (require 'conf-org))
(require 'conf-yasnippet)               ;模版系统
(with-eval-after-load 'compile (require 'conf-compile))
(with-eval-after-load 'cc-mode (require 'conf-program-objc))
(with-eval-after-load 'go-mode (require 'conf-program-golang))
(with-eval-after-load 'python (require 'conf-program-python))

(when (eq system-type 'darwin)
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))
(require 'exec-path-from-shell)
(setq exec-path-from-shell-check-startup-files nil) ;
(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-variables '("PATH"
                                         "GOPATH"
                                         "GOROOT"
                                         "GOBIN"
                                         "GOPROXY"
                                         "GOPRIVATE"
                                         "GO111MODULE"
                                         "GOSUMDB"))
  (exec-path-from-shell-initialize))

(with-eval-after-load 'dired (require 'conf-dired)) ;emacs文件浏览器，directory 管理理
(require 'conf-wgrep)

(require 'conf-centaur-tabs)
(require 'conf-tags)                    ;ctags gtags 相关，代码跳转
(require 'conf-company-mode)            ;补全
;; (with-eval-after-load 'magit (require 'conf-magit))

(global-undo-tree-mode t)
(global-font-lock-mode)
(transient-mark-mode 1)
(save-place-mode t)
(savehist-mode 1)
(recentf-mode 1)
(run-with-idle-timer 300 t 'vmacs-idle-timer) ;idle 300=5*60s
(require 'conf-vterm)

;;==============jixiuf======================
(require 'conf-evil-toby)        ;; vim操作

;; (require 'init-macros)
;; (require 'fira-code-mode)
(require 'conf-modeline)
;; (require 'init-lsp)          ;; lsp 相关
(require 'conf-git)         ;; git 版本控制 magit的配置


;; (require 'conf-rg)

;; (require 'conf-counsel)     ;; 搜索buffer文件
;; (require 'conf-evil-symbol)
(require 'conf-jump)
(require 'conf-tree)
;; (require 'conf-counsel)     ;; 搜索buffer文件
;; (require 'conf-awesome-tab) ;; tab页
(require 'conf-centaur-tabs-toby)
;; (require 'conf-ivy)         ;; ivy
(require 'conf-org-toby)         ;; org mode
(require 'conf-dired-toby)       ;; 文件目录操作
(require 'vmacs-dired-single)  ;确保只有一个dired buffer的存在
(require 'conf-projectile)
(require 'conf-iedit-toby)
(require 'conf-keybind)     ;; 键位绑定

(require 'conf-emacs) ;; emacs 的其他配置

(icomplete-vertical-mode)


(require 'gotests) ;; go test

(evil-collection-define-key 'normal 'magit-mode-map
  "q" #'my/quit-magit-buffer)



(defun enable-wgrep-when-entry-insert()
  (when (derived-mode-p  'rg-mode 'grep-mode 'embark-collect-mode)
    (require 'wgrep) (wgrep-change-to-wgrep-mode)))

(add-hook 'evil-insert-state-entry-hook 'enable-wgrep-when-entry-insert)

(evil-collection-define-key 'normal 'vc-annotate-mode-map
  "q" #'vmacs-kill-buffer-dwim)

(evil-collection-define-key 'insert 'vc-annotate-mode-map
  "q" #'vmacs-kill-buffer-dwim)


(defvar my-intercept-mode-map (make-sparse-keymap)
  "High precedence keymap.")

(define-minor-mode my-intercept-mode
  "Global minor mode for higher precedence evil keybindings."
  :global t)

(my-intercept-mode)

(dolist (state '(normal visual insert))
  (evil-make-intercept-map
   ;; NOTE: This requires an evil version from 2018-03-20 or later
   (evil-get-auxiliary-keymap my-intercept-mode-map state t t)
   state))

(evil-define-key 'normal my-intercept-mode-map
  (kbd "SPC f") 'find-file
  (kbd "q") #'vmacs-kill-buffer-dwim
  )