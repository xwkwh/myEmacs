(require 'recentf)
(recentf-mode)
(require 'counsel)
;; (eval-when-compile )
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq counsel-find-file-at-point t)
(setq ffap-machine-p-known 'accept)     ;起用counsel-find-file-at-point时 ，有平会莫名其妙地ping，此处禁用ping
(setq counsel-find-file-at-point t)
(setq counsel-preselect-current-file t)
(setq ivy-initial-inputs-alist nil)
(setq ivy-extra-directories '("./")) ; default value: ("../" "./")
(setq ivy-wrap t)
(setq ivy-count-format "")
;; (setq ivy-count-format "%d/%d ")
;; (setq ivy-virtual-abbreviate 'full) ; Show the full virtual file paths
;; (setq ivy-add-newline-after-prompt nil)
(setq ivy-height 25)
(setq ivy-fixed-height-minibuffer t)
(setq counsel-git-grep-skip-counting-lines t)
(setq counsel-git-grep-cmd-default "git --no-pager grep --full-name -n --no-color -i -e '%s'|cut -c -300") ;trunc long line
(setq counsel-rg-base-command  "rg -S --no-heading --line-number --color never  -z %s ." )


;; (setq magit-completing-read-function 'ivy-completing-read)
(setq ivy-ignore-buffers
       (list
        "\*EGLOT"
           "\\` "
           "\*Helm"
           "\*helm"
           "\*vc-diff\*"
           "\*magit-"
           "\*vc-"
           "*Backtrace*"
           "*Package-Lint*"
           ;; "todo.txt"
           "\*vc*"
           "*Completions*"
           "\*vc-change-log\*"
           "\*VC-log\*"
           "\*Async Shell Command\*"
           "\*Shell Command Output\n*"
           "\*sdcv\*"
           ;; "\*Messages\*"
           "\*Ido Completions\*"))

;; (setq enable-recursive-minibuffers t)
;; (global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (vmacs-leader "<lwindow>" 'ivy-switch-buffer) ;for windows
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x g") 'vmacs-counsel-rg)


(define-key ivy-minibuffer-map (kbd "C-c C-c") 'ivy-occur)




(with-eval-after-load 'counsel
  (define-key counsel-ag-map (kbd "C-;") 'vmacs-counsel-ag-toggle-git-root)
  (define-key counsel-ag-map (kbd "C-h") 'vmacs-counsel-ag-up-directory)
  (define-key counsel-git-grep-map (kbd "C-h") 'counsel-up-directory)
  (define-key counsel-git-grep-map (kbd "C-l") 'counsel-up-directory)
  )


(defadvice ivy--virtual-buffers (around counsel-git activate)
  "Append git files as virtual buffer"
  (let ((recentf-list recentf-list )
        (default-directory default-directory)
        list counsel--git-dir)
    (setq counsel--git-dir (counsel--git-root))
    (when counsel--git-dir
      (setq default-directory counsel--git-dir)
      (setq list (split-string (shell-command-to-string (format "git ls-files --full-name --|grep -v /snippets/|sed \"s|^|%s/|g\"" default-directory)) "\n" t))
      (setq recentf-list (append recentf-list list))
      )
    ad-do-it))

;;;###autoload
(defun vmacs-counsel-rg (&optional arg)
  "Use `counsel-rg' to search for the selected region or
 the symbol around point in the current project with riggrep"
  (interactive "P")
  (let ((input (if (region-active-p)
                   (buffer-substring-no-properties
                    (region-beginning) (region-end))
                 ""))
        (default-directory default-directory)
        (extra-rg-args ""))
    (when current-prefix-arg
      (setq extra-rg-args
            (read-from-minibuffer (format
                                   "%s args: "
                                   (car (split-string counsel-ag-command))))))
    (counsel-rg  input default-directory extra-rg-args
                 (concat "rg in " (abbreviate-file-name default-directory)))))


;;;###autoload
(defun vmacs-counsel-ag-up-directory ()
  "Go to the parent directory."
  (interactive)
  (let* ((cur-dir (directory-file-name (abbreviate-file-name default-directory)))
         (up-dir (abbreviate-file-name (file-name-directory (expand-file-name cur-dir)))))
    (setf (ivy-state-directory ivy-last) up-dir)
    (when (string-suffix-p cur-dir  (directory-file-name(ivy-state-prompt ivy-last)))
      ;; (setf (ivy-state-prompt ivy-last) (concat "rg in" up-dir))
      (setq ivy--prompt (concat "rg in " up-dir)))
    (setq default-directory up-dir))
  (counsel-ag-function ivy-text))


(defvar vmacs-last-ag-directory default-directory)
;;;###autoload
(defun vmacs-counsel-ag-toggle-git-root ()
  "Toggle go to the git root directory."
  (interactive)
  (if current-prefix-arg
      (vmacs-counsel-rg-select-directory)
    (let (dir (vc-root (vc-find-root default-directory ".git")))
      (if (string= (expand-file-name default-directory)
                   (expand-file-name vc-root))
          (setq dir (abbreviate-file-name (or vmacs-last-ag-directory default-directory)))
        (setq dir (abbreviate-file-name vc-root)))
      (setf (ivy-state-directory ivy-last) dir)
      ;; (setf (ivy-state-prompt ivy-last) (concat "rg in " dir))
      (setq ivy--prompt (concat "rg in " dir))
      (setq vmacs-last-ag-directory default-directory)
      (setq default-directory dir))
    (counsel-ag-function ivy-text)))


(defvar vmacs-last-ivy-text )
;; (defvar vmacs-last-state )
;;;###autoload
(defun vmacs-counsel-rg-select-directory()
  " dynamicly select directory in counsel-ag session."
  (interactive)
  (setq vmacs-last-ivy-text (or ivy-text ""))
  ;; (setq vmacs-last-state ivy-last)
  (ivy-quit-and-run
    (let ((extra-rg-args "")
          (default-directory default-directory))
      (setq default-directory (read-directory-name "rg in directory:"))
      (setq ivy-last vmacs-last-ivy-text)
      (counsel-rg  vmacs-last-ivy-text default-directory extra-rg-args
                   (concat "rg in " (abbreviate-file-name default-directory)))


      )
    ))

;;;;;;;;;;;;;;;;;;;

;;;###autoload
(defun ivy-occur-hide-lines-not-matching (search-text)
  "Hide lines that don't match the specified regexp."
  (interactive "MHide lines not matched by regexp: ")
  (set (make-local-variable 'line-move-ignore-invisible) t)
  (save-excursion
    (goto-char (point-min))
    (forward-line 4)
    (let ((inhibit-read-only t)
          (start-position (point))
          (pos (re-search-forward search-text nil t)))
      (while pos
        (beginning-of-line)
        (delete-region start-position (point))
        (forward-line 1)
        (setq start-position (point))
        (if (eq (point) (point-max))
            (setq pos nil)
          (setq pos (re-search-forward search-text nil t))))
              (delete-region start-position (point-max) ))))

;;;###autoload
(defun ivy-occur-hide-lines-matching  (search-text)
  "Hide lines matching the specified regexp."
  (interactive "MHide lines matching regexp: ")
  (set (make-local-variable 'line-move-ignore-invisible) t)
  (save-excursion
    (goto-char (point-min))
    (forward-line 4)
    (let ((inhibit-read-only t)
          (pos (re-search-forward search-text nil t))
          start-position)
      (while pos
        (beginning-of-line)
        (setq start-position (point))
        (end-of-line)
        (delete-region start-position (+ 1 (point)))
        (if (eq (point) (point-max))
            (setq pos nil)
          (setq pos (re-search-forward search-text nil t)))))))

;; 全局搜索完湖过滤 C-c C-c
(define-key ivy-occur-grep-mode-map (kbd "/") 'ivy-occur-hide-lines-not-matching)
(define-key ivy-occur-grep-mode-map (kbd "z") 'ivy-occur-hide-lines-matching)

(provide 'conf-counsel)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-ivy.el</tmp> ends here.
