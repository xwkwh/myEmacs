;; https://github.com/saibing/tools
;; go get  golang.org/x/tools/cmd/gopls


(add-hook 'go-mode-hook 'vmacs-go-mode-hook)
(defun vmacs-go-mode-hook()
  (evil-collection-define-key 'normal 'go-mode-map "gd" )
  (eglot-ensure)
  (flycheck-mode)
  (setq eglot-workspace-configuration
        ;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
        '((:gopls . (:usePlaceholders t :completeUnimported  t :staticcheck t
                                      :semanticTokens t
                                      :directoryFilters ["-vendor"]
                                      :analyses  (:unusedparams t :unusedwrite t)
                                      :annotations (:bounds t :escape t :inline t :nil t)
                                      :allExperiments t
                                      :experimentalWorkspaceModule t
                                      ;; :buildFlags ["-mod=readonly"]
                                      :allowImplicitNetworkAccess t
                                      :allowModfileModifications t))))

  (add-hook 'before-save-hook 'gofmt-before-save nil t)
  ;; (add-hook 'before-save-hook #'gofmt)
  ;; (setq flycheck-mode t)
  ;; (setq require-final-newline nil)
  ;; (modify-syntax-entry ?_  "_" (syntax-table)) ;还是让 "_" 作为symbol，还不是word
  (local-set-key (kbd "C-c i") 'go-goto-imports)

  (local-set-key (kbd "C-c f") #'gofmt)
  (local-set-key (kbd "C-c g") 'golang-setter-getter))

(setq-default eglot-workspace-configuration
              ;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
              '((:gopls .
                        ((usePlaceholders . t)
                         (completeUnimported . t) ;; :staticcheck t
                         (directoryFilters . ["-vendor"])
                         (buildFlags . ["-mod=mod"])
                         (allowImplicitNetworkAccess . t)
                         (experimentalWorkspaceModule  . t)
                         (allowModfileModifications . t)))))

;; (require 'project)

;; (defun project-find-go-module (dir)
;;   (when-let ((root (locate-dominating-file dir "go.mod")))
;;     (cons 'go-module root)))

;; (cl-defmethod project-root ((project (head go-module)))
;;   (cdr project))

;; (add-hook 'project-find-functions #'project-find-go-module)


(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))



(setq flycheck-golangci-lint-config "~/standards/go/.golangci.yml")

(require 'gotests)               ;; go test

(provide 'conf-program-golang)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-golang.el ends here.
