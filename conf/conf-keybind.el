
(evil-leader/set-key "b" 'evil-search-highlight-persist-remove-all)
;; (evil-leader/set-key "SPC"   'ivy-switch-buffer)
(evil-leader/set-key "SPC"   'vmacs-switch-buffer)

(autoload 'dired-jump "dired-x" "dired-jump" t)
(evil-leader/set-key "j" 'dired-jump) ;; 跳到当前目录文件
(evil-leader/set-key "s" 'evil-write-all) ;; 保存全部  
;; (evil-leader/set-key  "ff" 'counsel-find-file)
(evil-leader/set-key  "ff" 'dired)
(evil-leader/set-key  "ft" #'(lambda()(interactive)(let ((default-directory "/tmp/"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key  "fh" #'(lambda()(interactive)(let ((default-directory "~"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key "vj" 'magit-status) ;like dired-jump
(evil-leader/set-key "va" 'vc-annotate)  ;like dired-jump
(evil-leader/set-key "m" 'toggle-frame-fullscreen)  ;like dired-jump
(evil-leader/set-key "l" 'ibuffer)
(evil-leader/set-key "vc" 'vc-msg-show)
(evil-leader/set-key "w" 'other-window)
(evil-leader/set-key "1" 'delete-other-windows)
;; lsp查看方法被调用
(evil-leader/set-key "u" 'lsp-find-references)
(evil-leader/set-key "." 'vterm-toggle)
(evil-leader/set-key "," 'counsel-imenu) ;; 查看当前文件的方法和变量列表

(evil-leader/set-key "k" 'kill-current-buffer)
(evil-leader/set-key "t" 'neotree-toggle)

;;代码注释工作，如果有选中区域，则注释或者反注释这个区域
;;如果，没选中区域，则注释或者注释当前行，如果光标在行末，则在行末添加或删除注释
;;;###autoload
(defun vmacs-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'vmacs-comment-dwim-line)
(global-set-key (kbd "C-.") 'vterm-toggle-cd)
(global-set-key (kbd "s-.") 'vterm-toggle)

;; (general-create-definer my-local-leader-def
;;   ;; :prefix my-local-leader
;;   :prefix "C")

;; (require 'general)
;; ;; ** Mode Keybindings
;; (my-local-leader-def
;;   :states 'normal
;;   "C" 'vterm-toggle
;;   )

;; (global-set-key (kbd "C-C") 'vterm-toggle-cd)
(define-key evil-normal-state-map (kbd "C-.") nil)




;; q可以直接退出一些buffer
(define-key transient-map        "q" 'transient-quit-one)
(define-key transient-edit-map   "q" 'transient-quit-one)
(define-key transient-sticky-map "q" 'transient-quit-seq)


(require 'vterm)
(require 'vterm-toggle)

(setq vterm-toggle-fullscreen-p t)

(defun vmacs-vterm-hook()
  (let ((p (get-buffer-process (current-buffer))))
    (when p
      (set-process-query-on-exit-flag p nil))))

(defun vmacs-kill-buffer-hook()
  (let ((proc (get-buffer-process (current-buffer))))
    (when (and (derived-mode-p 'vterm-mode)
               (process-live-p proc))
      (vterm-send-C-c)
      (kill-process proc))))

(add-hook 'kill-buffer-hook 'vmacs-kill-buffer-hook)


(add-hook 'vterm-mode-hook 'vmacs-vterm-hook)

;; (add-hook 'kill-buffer-hook 'vmacs-kill-buffer-hook)


(define-key vterm-mode-map (kbd "s-t")   #'vterm)
(defun vmacs-auto-exit(buf event)
  (when buf (kill-buffer buf)))

(add-hook 'vterm-exit-functions #'vmacs-auto-exit)

;; (global-set-key (kbd "SPC-,") 'hs-toggle-hiding)

(defun my-comment-code ()
  "Comment code"
  (interactive)
  (hs-minor-mode 1)
  (hs-toggle-hiding)
  )
(evil-leader/set-key "/" 'my-comment-code) ;; 代码折叠
 
(global-set-key (kbd "C-d") 'golden-ratio-scroll-screen-up) 

(global-set-key (kbd "C-b") 'golden-ratio-scroll-screen-down) ;M-v
(define-key evil-motion-state-map (kbd "C-d") nil)
(define-key evil-motion-state-map (kbd "C-b") nil)
(define-key evil-motion-state-map (kbd "C-a") nil)
(define-key evil-motion-state-map (kbd "C-e") nil)
(define-key evil-insert-state-map (kbd "C-b") nil)
(define-key evil-insert-state-map (kbd "C-d") nil)
(define-key evil-insert-state-map (kbd "C-a") nil)
(define-key evil-insert-state-map (kbd "C-e") nil)

(define-key c++-mode-map (kbd "C-d") nil)
(define-key c-mode-base-map (kbd "C-d") nil)



(define-key evil-normal-state-map "m" nil)
(define-key evil-normal-state-map "s" nil)
(define-key evil-motion-state-map "sv" 'evil-visual-char) ;==v开始选中区域
(define-key evil-motion-state-map "sm" 'evil-visual-line) ;==V 开始行选中
;; 因为C-v用于滚屏，故mv==原vim的C-v
(define-key evil-normal-state-map "mv" 'evil-visual-block) ;==vim.C-v 开始矩形操作，然后移动位置，就可得到选区

(define-key evil-visual-state-map "n" 'rectangle-number-lines) ;C-xrN

(global-set-key  (kbd "C-2") 'set-mark-command)

;; 选中区域后 交换当前光标点，
(define-key evil-visual-state-map "x" 'exchange-point-and-mark)
(define-key evil-visual-state-map "X" 'evil-visual-exchange-corners)

(global-set-key (kbd "M-l") 'goto-line)



;; 有一种需要是
;; 当我取消选中后 我希望光标停留在选中前光标所在的位置而不是在选区的开头或结尾处
;;
;; (define-key evil-normal-state-map "mf" 'evil-mark-defun) ;mark-defun 相当于C-M-h
;; (define-key evil-normal-state-map "mh" 'evil-M-h)        ;相当于M-h
;; (define-key evil-normal-state-map "mxh" 'evil-mark-whole-buffer) ;相当于C-xh
;; (define-key evil-normal-state-map "mb" 'evil-mark-whole-buffer);相当于C-xh


;; (require 'bm)
;; (autoload 'pulse-momentary-highlight-region "pulse")

;; (defvar evil-mark-funs-marker nil)

;; ;; (defadvice keyboard-quit (before save-marker-when-mark-region activate)
;; ;;   "goto init position after quit mark region"
;; ;;   (when (and (member last-command '(evil-mark-defun
;; ;;                                     evil-M-h
;; ;;                                     evil-mark-whole-buffer
;; ;;                                     evil-indent))
;; ;;              ;; (region-active-p)
;; ;;              evil-mark-funs-marker)
;; ;;     (goto-char (marker-position evil-mark-funs-marker))
;; ;;     (setq evil-mark-funs-marker nil)
;; ;;     (bm-bookmark-remove)))
;; (defun go-back-after-mark-region()
;;   (when (and evil-mark-funs-marker
;;              (not mark-active))
;;     (goto-char (marker-position evil-mark-funs-marker))
;;     (setq evil-mark-funs-marker nil)
;;     (bm-bookmark-remove)))

;;   (add-hook 'post-command-hook 'go-back-after-mark-region)

;; ;;;###autoload
;; (defun evil-mark-defun(&optional arg)
;;   "call function binding to `C-M-h'"
;;   (interactive)
;;   (setq evil-mark-funs-marker (point-marker))
;;   (bm-bookmark-add)
;;   (call-interactively (key-binding (kbd "C-M-h")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-h"))))))
;; ;;;###autoload
;; (defun evil-M-h(&optional arg)
;;   "call function binding to `M-h'"
;;   (interactive)
;;   (setq evil-mark-funs-marker (point-marker))
;;   (bm-bookmark-add)
;;   (call-interactively (key-binding (kbd "M-h")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "M-h"))))))
;; ;;;###autoload
;; (defun evil-mark-whole-buffer(&optional arg)
;;   "call function binding to `C-xh'"
;;   (interactive)
;;   (setq evil-mark-funs-marker (point-marker))
;;   (bm-bookmark-add)
;;   (call-interactively (key-binding (kbd "C-x h")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-x h"))))))
;; ;;;###autoload
;; (defun evil-begin-of-defun(&optional arg)
;;   "call function binding to `C-M-a'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "C-M-a")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-a"))))))
;; ;;;###autoload
;; (defun evil-end-of-defun(&optional arg)
;;   "call function binding to `C-M-e'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "C-M-e")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-e"))))))
;; ;;;###autoload
;; (defun evil-M-e(&optional arg)
;;   "call function binding to `M-e'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "M-e")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "M-e"))))))
;; ;;;###autoload
;; (defun evil-M-a(&optional arg)
;;   "call function binding to `M-a'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "M-a")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "M-a"))))))

;; ;;;###autoload
;; (defun evil-C-M-f(&optional arg)
;;   "call function binding to `C-M-f'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "C-M-f")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-f"))))))
;; ;;;###autoload
;; (defun evil-C-M-b(&optional arg)
;;   "call function binding to `C-M-b'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "C-M-b")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-b"))))))
;; ;;;###autoload
;; (defun evil-C-M-k(&optional arg)
;;   "call function binding to `C-M-k'"
;;   (interactive)
;;   (call-interactively (key-binding (kbd "C-M-k")))
;;   (message (concat "call function: "
;;                    (symbol-name (key-binding (kbd "C-M-k"))))))

(defvar boring-window-modes
  '(help-mode compilation-mode log-view-mode log-edit-mode
              org-agenda-mode magit-revision-mode ibuffer-mode))


(defun vmacs-filter(buf ignore-buffers)
  (cl-find-if
   (lambda (f-or-r)
     (if (functionp f-or-r)
         (funcall f-or-r buf)
       (string-match-p f-or-r buf)))
   ignore-buffers))

(defun bury-boring-windows(&optional bury-cur-win-if-boring)
  "close boring *Help* windows with `C-g'"
  (let ((opened-windows (window-list))
        (cur-buf-win (get-buffer-window)))
    (dolist (win opened-windows)
      (with-current-buffer (window-buffer win)
        (when (or (memq  major-mode boring-window-modes)
                  (vmacs-filter (buffer-name) ivy-ignore-buffers))
          (when (and (>  (length (window-list)) 1)
                     (or bury-cur-win-if-boring
                         (not (equal cur-buf-win win)))
                     (delete-window win))))))))


(defadvice keyboard-quit (before bury-boring-windows activate)
  (let ((win (active-minibuffer-window)))
    (when (windowp win)
      (switch-to-buffer (window-buffer win))))

  (when (equal last-command 'keyboard-quit)
    (bury-boring-windows )))

(defun ct/quit-and-kill-auxiliary-windows ()
  "Kill buffer and its window on quitting"
  (local-set-key (kbd "q") 'kill-buffer-and-window))
;; q是关掉buffer 而不是离开窗口
(add-hook 'special-mode-hook 'ct/quit-and-kill-auxiliary-windows)
(add-hook 'compilation-mode-hook 'ct/quit-and-kill-auxiliary-windows)
(add-hook 'dired-mode-hook 'ct/quit-and-kill-auxiliary-windows)

(global-set-key (kbd "C-x C-e") 'eval-print-last-sexp)

(provide 'conf-keybind)
