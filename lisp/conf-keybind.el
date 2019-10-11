
(evil-leader/set-key "b" 'evil-search-highlight-persist-remove-all)
(evil-leader/set-key "SPC"   'ivy-switch-buffer)
(autoload 'dired-jump "dired-x" "dired-jump" t)
(evil-leader/set-key "j" 'dired-jump) ;; 跳到当前目录文件
(evil-leader/set-key "s" 'evil-write-all) ;; 保存全部  
(evil-leader/set-key  "ff" 'counsel-find-file)
(evil-leader/set-key  "ft" #'(lambda()(interactive)(let ((default-directory "/tmp/"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key  "fh" #'(lambda()(interactive)(let ((default-directory "~"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key  "fg" #'(lambda()(interactive)(let ((default-directory "~/gopath/src/gitlab.luojilab.com/igetserver"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key "g" 'vmacs-counsel-rg) ;; 搜索当前目录下 根据单词 + 空格
(evil-leader/set-key "vj" 'magit-status) ;like dired-jump

;; lsp查看方法被调用
(evil-leader/set-key "u" 'lsp-find-references)
(evil-leader/set-key "." 'vterm-toggle)
(evil-leader/set-key "," 'hs-toggle-hiding) ;; 代码折叠

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
;; (global-set-key (kbd "C-C") 'vterm-toggle-cd)
(define-key evil-normal-state-map (kbd "C-.") nil)




;; q可以直接退出一些buffer
(define-key transient-map        "q" 'transient-quit-one)
(define-key transient-edit-map   "q" 'transient-quit-one)
(define-key transient-sticky-map "q" 'transient-quit-seq)


(require 'vterm)
(require 'vterm-toggle)

(define-key vterm-mode-map (kbd "s-t")   #'vterm)
(defun vmacs-auto-exit(buf)
  (when buf (kill-buffer buf)))

(add-hook 'vterm-exit-functions #'vmacs-auto-exit)

;; (global-set-key (kbd "SPC-,") 'hs-toggle-hiding)


(provide 'conf-keybind)
