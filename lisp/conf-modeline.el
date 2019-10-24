;; (require 's)
;; (require 'powerline)

;; (defvar my/mode-line-border 8)
;; (defvar my/modeline-height 22)

;; (set-face-attribute 'mode-line nil :family "M+ 1m" :height 120
;;                     :background "gray20" :foreground "white"
;;                     :weight 'normal
;;                     :box `(:line-width ,my/mode-line-border :color "gray20" :style nil))

;; (set-face-attribute 'mode-line-inactive nil :inherit 'mode-line
;;                     :background "gray20" :foreground "gray50"
;;                     :box `(:line-width ,my/mode-line-border :color "gray20" :style nil))


;; ;; remove things I don't use
;; (setq-default mode-line-front-space '(:eval (format-time-string "W%y%V")))
;; (setq-default mode-line-mule-info "")
;; (setq-default mode-line-remote "")
;; (setq-default mode-line-frame-identification "")
;; (setq-default mode-line-position "") ;; I use line-number-mode instead
;; (setq-default mode-line-modes '("%[" mode-name mode-line-process "%n" "%]"))
;; (setq-default mode-line-end-spaces "")

;; ;; show the buffer status with brighter colors

;; (make-face 'mode-line-read-only-face)
;; (set-face-attribute 'mode-line-read-only-face nil :inherit 'mode-line
;;                     :foreground "#b3d5e6"
;;                     :box '(:line-width -5 :color "#3f95bf"))

;; (make-face 'mode-line-modified-face)
;; (set-face-attribute 'mode-line-modified-face nil :inherit 'mode-line
;;                     :foreground "#c82829" :background "GoldenRod2"
;;                     :box '(:line-width -5 :color "#c82829"))

;; (setq-default mode-line-modified
;;               '(:eval
;;                 (cond (buffer-read-only
;;                        (propertize " RO " 'face 'mode-line-read-only-face))
;;                       ((buffer-modified-p)
;;                        (propertize " ** " 'face 'mode-line-modified-face))
;;                       (t "    "))))

;; ;; show both directory and buffer name

;; (set-face-attribute 'mode-line-buffer-id nil :inherit 'mode-line :foreground "green")

;; (make-face 'mode-line-folder-face)
;; (set-face-attribute 'mode-line-folder-face nil :inherit 'mode-line
;;                     :family "Fira Sans Condensed" :height 150)

;; (make-face 'mode-line-filename-face)
;; (set-face-attribute 'mode-line-filename-face nil :inherit 'mode-line
;;                     :family "Fira Sans Condensed" :height 150
;;                     :foreground "white" :background "#3f95bf")

;; (defun my/modeline-project-root ()
;;   (or (cdr (project-current)) default-directory))

;; (defun my/modeline-buffer-id ()
;;   (cond (buffer-file-name
;;          (s-chop-prefix (my/modeline-project-root) buffer-file-name))
;;         (t "%b")))

;; (defun my/shorten-directory (dir max-length)
;;   "Show directory name DIR with up to MAX-LENGTH characters."
;;   (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
;;         (output ""))
;;     (when (and path (equal "" (car path)))
;;       (setq path (cdr path)))
;;     (while (and path (< (length output) (- max-length 4)))
;;       (setq output (concat (car path) "/" output))
;;       (setq path (cdr path)))
;;     (when path
;;       (setq output (concat "…/" output)))
;;     output))


;; (setq-default mode-line-buffer-identification
;;               `(
;;                 (:propertize
;;                  (:eval
;;                   (my/shorten-directory
;;                    (my/modeline-project-root)
;;                    (- (window-width) (length (my/modeline-buffer-id)) 60)))
;;                  face mode-line-folder-face)
;;                 (:propertize " "
;;                              face mode-line-filename-face
;;                              display ,(powerline-wave-right 'mode-line-folder-face nil my/modeline-height))
;;                 (:propertize
;;                  (:eval (my/modeline-buffer-id))
;;                  face mode-line-filename-face)
;;                 (:propertize " "
;;                              face mode-line-filename-face
;;                              display ,(powerline-wave-left nil 'mode-line-folder-face my/modeline-height))
;;                 ))



(require 'powerline)
;; (powerline-evil-vim-color-theme)  
;; (display-time-mode t)

(require 'powerline-evil)
(set-face-attribute 'powerline-evil-normal-face nil :background "dark green")


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;test;;;;;;;;;;;;;

(defun my-line-theme ()
  "Powerline's Vim-like mode-line with evil state at the beginning in color."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (powerline-raw (powerline-evil-tag) evil-face)))
				     (powerline-raw "%f" mode-line 'l)
                                     ;; (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
                                     ;; (powerline-raw "[" mode-line 'l)
                                     ;; (powerline-major-mode mode-line)
                                     ;; (powerline-process mode-line)
                                     ;; (powerline-raw "]" mode-line)
                                     ;; (when (buffer-modified-p)
                                     ;;   (powerline-raw "[+]" mode-line))
                                     ;; (when buffer-read-only
                                     ;;   (powerline-raw "[RO]" mode-line))
                                     ;; (powerline-raw "[%z]" mode-line)
                                     ;; ;; (powerline-raw (concat "[" (mode-line-eol-desc) "]") mode-line)
                                     ;; (when (and (boundp 'which-func-mode) which-func-mode)
                                     ;;   (powerline-raw which-func-format nil 'l))
                                     ;; (when (boundp 'erc-modified-channels-object)
                                     ;;   (powerline-raw erc-modified-channels-object face1 'l))
                                     ;; (powerline-raw "[" mode-line 'l)
                                     ;; (powerline-minor-modes mode-line)
                                     ;; (powerline-raw "%n" mode-line)
                                     ;; (powerline-raw "]" mode-line)
                                     ;; (when (and vc-mode buffer-file-name)
                                     ;;   (let ((backend (vc-backend buffer-file-name)))
                                     ;;     (when backend
                                     ;;       (concat (powerline-raw "[" mode-line 'l)
                                     ;;               (powerline-raw (format "%s / %s" backend (vc-working-revision buffer-file-name backend)))
                                     ;;               (powerline-raw "]" mode-line)))))
			       ))
                          (rhs (list
				     ;; (powerline-raw '(10 "%i"))
                                     ;; (powerline-raw global-mode-string mode-line 'r)
                                     ;; (powerline-raw "%l," mode-line 'l)
                                     ;; (powerline-raw (format-mode-line '(10 "%c")))
				     (powerline-raw (replace-regexp-in-string  "%" "%%" (format-mode-line '(-3 "%p"))) mode-line 'r)
				     (powerline-raw vc-mode mode-line 'r)
				)))
                     (concat (powerline-render lhs)
                             (powerline-fill mode-line (powerline-width rhs))
                             (powerline-render rhs)))))))

;; (get-text-property 0 'face nil)
;; ;;; 自定义 mode line
;; (setq-default mode-line-format '(
;; 				 "%e"
;; 				 (:eval
;; 				  (window-numbering-get-number-string))
;; 				 ;; mode-line-front-space
;; 				 ;; mode-line-mule-info
;; 				 ;; mode-line-client
;; 				 ;; mode-line-modified -- show buffer change or not
;; 				 ;; mode-line-remote -- no need to indicate this specially
;; 				 ;; mode-line-frame-identification -- this is for text-mode emacs only
;; 				 ;; "["
;; 				 ;; mode-name
;; 				 ;; ":"
;; 				 mode-line-buffer-identification
;; 				 "%f"
;; 				 ;; "]"
;; 				 " "
;; 				 mode-line-position
;; 				 (vc-mode vc-mode)
;; 				 " "
;; 				 ;; mode-line-modes -- move major-name above
;; 				 ;; "["
;; 				 ;; minor-mode-alist
;; 				 ;; "]"
;; 				 ;; mode-line-misc-info
;; 				 ;; mode-line-end-spaces
;; 				 ))




;; (set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "black")


(my-line-theme)
(provide 'conf-modeline)
