;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                       ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; (setq package-archives '(("gnu"   . "http://mirrors.163.com/elpa/gnu/")
;;                        ("melpa" . "http://mirrors.163.com/elpa/melpa/")))


;; (setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
;; 			("org"  .  "http://mirrors.cloud.tencent.com/elpa/org/")
;;                          ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
(setq url-using-proxy t)
(setq url-proxy-services '(("http" . "127.0.0.1:12639")))

;; (setq url-proxy-services
;;    '(
;;      ("http" . "http://127.0.0.1:12639")
;;      ("https" . "http://127.0.0.1:12639")))

(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
 (when (eq system-type 'darwin)
       (require 'exec-path-from-shell)
     (exec-path-from-shell-initialize))

(defvar lazy-load-dir (concat user-emacs-directory "lazy"))
(add-to-list 'load-path lazy-load-dir)
(require 'conf-lazy-load)               ;autoload相关，加快emacs启动速度

(require 'conf-macro)

(when (< emacs-major-version 27) (package-initialize))

(require 'conf-lazy-load)               ;autoload相关，加快emacs启动速度

(require 'conf-minibuffer)
(require 'conf-icomplete)

(require 'conf-custom)
(require 'conf-evil)        ;; vim操作

(require 'conf-tags)                    ;ctags gtags 相关，代码跳转
;; (with-eval-after-load 'eglot (define-key eglot-mode-map (kbd "C-h .") 'eglot-help-at-point))
(require 'conf-company-mode)            ;补全
(with-eval-after-load 'go-mode (require 'conf-program-golang))
(with-eval-after-load 'python (require 'conf-program-python))
(with-eval-after-load 'cc-mode (require 'conf-program-objc))

(require 'init-view)        ;; 显示相关

(icomplete-vertical-mode)


;; (require 'init-macros)
;; (require 'fira-code-mode)
(require 'conf-modeline)
;; (require 'init-lsp)          ;; lsp 相关
(require 'conf-git)         ;; git 版本控制 magit的配置


(require 'conf-rg)

(require 'conf-evil-symbol)
(require 'conf-jump)
(require 'conf-tree)
;; (require 'conf-counsel)     ;; 搜索buffer文件
;; (require 'conf-awesome-tab) ;; tab页
(require 'conf-centaur-tabs)
;; (require 'conf-ivy)         ;; ivy
(require 'init-org)         ;; org mode
(require 'conf-dired)       ;; 文件目录操作
(require 'vmacs-dired-single)  ;确保只有一个dired buffer的存在
(require 'conf-projectile)
(require 'conf-iedit)
(require 'conf-keybind)     ;; 键位绑定
;; (require 'init-themes)

(require 'conf-emacs) ;; emacs 的其他配置



(put 'dired-find-alternate-file 'disabled nil)
