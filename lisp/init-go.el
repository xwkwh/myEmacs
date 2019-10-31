
(setq exec-path-from-shell-check-startup-files nil) ;

(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-variables '("PATH"
					 "GOPATH"
					 "GOROOT"
					 "GOBIN"))
  (exec-path-from-shell-initialize))



;;;custom go ide
;;(require 'go-eldoc)
(require 'yasnippet)
(require 'go-mode)
;;(require 'go-autocomplete)
;;(require 'auto-complete-config)
;;(require 'golint)
					; (ac-config-default)
(setq lsp-auto-configure nil)
(defun go-mode-setup ()
 ;; (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; (lsp)
  (lsp-deferred)
  (flymake-mode -1)
  (setq company-backends `((company-lsp company-yasnippet company-files )))
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)


(require 'lsp-clients)


					; (add-hook 'go-mode-hook 'vmacs-go-mode-hook)


(global-company-mode 1)

(company-posframe-mode 1)

(define-key company-active-map (kbd "C-s") #'company-filter-candidates)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)


(setq company-lsp-cache-candidates  'auto)
(provide 'init-go)
;;;
