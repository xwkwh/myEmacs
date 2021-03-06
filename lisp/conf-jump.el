(dumb-jump-mode)
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'go-mode-hook 'counsel-gtags-mode)

(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))


;; (vmacs-leader "," 'bm-previous)  ;space, 回到上一个书签

(define-key evil-normal-state-map (kbd "C-o") 'bm-previous)
;; (define-key evil-normal-state-map (kbd "C-i") 'bm-next)

(require 'bm)
(setq-default
 bm-recenter nil                        ;跳转到书签处时，是否将其调整到屏幕中心
 bm-highlight-style 'bm-highlight-only-fringe ;书签以何种形式展示
 bm-cycle-all-buffers t                           ;书签跳转时，是在当前buffer间跳转还是在所有buffer间跳转
 bm-in-lifo-order t)                              ;是否按照书签的添加顺序进行跳转（默认是从上到下按位置顺序跳转）

(defun vmacs-bm-fringe(&optional frame)
  (with-selected-frame frame
    (when (fboundp 'define-fringe-bitmap)
      (define-fringe-bitmap 'bm-marker-left   [#x00 #x00 #xFC #xFE #x0F #xFE #xFC #x00])
      (define-fringe-bitmap 'bm-marker-right  [#x00 #x00 #x3F #x7F #xF0 #x7F #x3F #x00]))))

(add-hook 'after-make-frame-functions 'vmacs-bm-fringe)

;; (setq-default bm-buffer-persistence t)
;; (setq-default bm-restore-repository-on-load t)
;; (require 'bm)
;; (add-hook' after-init-hook 'bm-repository-load)
;; (add-hook 'find-file-hooks 'bm-buffer-restore)
;; (add-hook 'kill-buffer-hook 'bm-buffer-save)
;; (add-hook 'kill-emacs-hook '(lambda nil
;;                               (bm-buffer-save-all)
;;                               (bm-repository-save)))

;; (add-hook 'after-revert-hook 'bm-buffer-restore)

;; (global-set-key (kbd "C-.") 'bm-toggle)
;; (global-set-key (kbd "C-,")   'bm-next)

;; (global-set-key (kbd "M-.") 'bm-toggle)
;; (global-set-key (kbd "M-/")   'bm-next)
;; (global-set-key (kbd "M-,") 'bm-previous)


;; 按下ctrl-g时，如果当前光标处有书签，则删除此书签
(with-eval-after-load 'bm
  (defadvice keyboard-quit (before rm-bm-bookmark activate)
    "rm bm bookmark "
    (bm-bookmark-remove)))


;; evil-mode 存在jump机制，即光标在大范围移动时
;; (比如gd evil-goto-definition用于跳转到函数定义的地方)，会在原来的地方
;; 设置一个标记以便可以跳回到原处,默认ctrl-o ctrl-i 进行跳前跳后
;; (define-key evil-motion-state-map (kbd "C-o") 'evil-jump-backward)
;; (define-key evil-motion-state-map (kbd "C-i") 'evil-jump-forward)
;;

;; 有了下面的功能当evil-mode在某个地方设置标记时，同时在那里加一个可视化书签
;; 则利用可视化书签的跳转功能就可以进行前后跳转
(defadvice evil-set-jump (around evil-jump activate)
  (when (symbolp this-command)
    (unless (string-match "bm-.*" (symbol-name this-command))
      (bm-bookmark-add nil nil t))
    ad-do-it)
  )
;; isearch 搜索的时候也会进行大范围的光标移动，会在原处加书签，
;; 当取消搜索时,光标后回到原处，则将此处的书签去掉
(defadvice isearch-cancel(around evil-jump-remomve activate)
  (goto-char isearch-opoint)
  (bm-bookmark-remove)
  ad-do-it)

(add-hook 'post-command-hook  'vmacs-auto-remove-bm)
(defun vmacs-auto-remove-bm()
  (when (and (symbolp this-command)
             (member this-command
                     '(evil-previous-line
                       evil-forward-char
                       evil-backward-char
                       next-line
                       previous-line
                       evil-next-line)))
    (bm-bookmark-remove)))

;; 在光标处手动添加一个书签
;; (define-key evil-normal-state-map "mm" 'bm-toggle) ;evil-set-marker


;; 跳转到函数定义的地方，跳转前在原处设置一个书签,space,可回原处
;; default bind on gd
;;;###autoload
(defun goto-definition (&optional arg)
  "Make use of emacs' find-func and etags possibilities for finding definitions."
  (interactive "P")
  (let ((line (buffer-substring-no-properties
               (line-beginning-position) (line-end-position))))
    (bm-bookmark-add line nil nil)        ;跳转前在原处加一个书签
    (cl-case major-mode
      (emacs-lisp-mode
       (elisp-def-mode 1)
       (condition-case nil (call-interactively 'elisp-def)
         (error (bm-bookmark-remove))))
      (lisp-interaction-mode
       (elisp-def-mode 1)
       (condition-case nil (call-interactively 'elisp-def)
         (error (bm-bookmark-remove))))
      (js-mode
       (if (functionp 'tern-find-definition)
           (call-interactively 'tern-find-definition)
         (lsp-find-definition)))
      (go-mode
       (condition-case nil (lsp-find-definition)
         (error (call-interactively 'godef-jump)))
       )
      (otherwise
       (condition-case nil (lsp-find-definition)
         (error (bm-bookmark-remove))))))

  (setq this-command 'goto-definition))

(define-key evil-motion-state-map "gd" 'goto-definition)
(require 'cc-mode)
(define-key c-mode-map (kbd "C-d") nil)


(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))


(provide 'conf-jump)
