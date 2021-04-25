;; e ,r 移动
(define-key evil-normal-state-map "e" 'evil-forward-symbol-begin)
(define-key evil-normal-state-map "r" 'evil-forward-symbol-end)
;; (define-key evil-normal-state-map "E" 'evil-forward-symbol-end)
(define-key evil-normal-state-map "v" 'evil-backward-symbol-begin)
;; (define-key evil-normal-state-map ";" 'evil-repeat-find-char-or-evil-backward-symbol-begin)
;; (define-key evil-normal-state-map "R" 'evil-backward-symbol-end)

(define-key evil-visual-state-map "e" 'evil-forward-symbol-begin)
(define-key evil-visual-state-map "r" 'evil-forward-symbol-end)
;; (define-key evil-visual-state-map "E" 'evil-forward-symbol-end)
(define-key evil-visual-state-map "v" 'evil-backward-symbol-begin)
;; (define-key evil-visual-state-map "R" 'evil-backward-symbol-end)


;; de dr
(define-key evil-motion-state-map "e" 'evil-forward-symbol-end)
(define-key evil-motion-state-map "r" 'evil-backward-symbol-begin)
;; dae die
(define-key evil-outer-text-objects-map "e" 'evil-a-symbol)
(define-key evil-inner-text-objects-map "e" 'evil-inner-symbol)



;;;###autoload
(evil-define-motion evil-forward-symbol-begin(count)
  "Move to the end of the COUNT-th next symbol."
  ;; :jump t
  :type exclusive
  (evil-signal-at-bob-or-eob count)
  (evil-forward-beginning 'evil-symbol count)
  (let ((sym (thing-at-point 'evil-symbol)))
    (while (and sym (not (string-match "\\<" sym)))
      (evil-signal-at-bob-or-eob count)
      (evil-forward-beginning 'evil-symbol 1)
      (setq sym (thing-at-point 'evil-symbol))
      )
    )
  )

;;;###autoload
(evil-define-motion evil-backward-symbol-begin(count)
  "Move to the end of the COUNT-th next symbol."
  ;; :jump t
  :type exclusive
  ;; (forward-evil-symbol count)
  (evil-backward-beginning 'evil-symbol count)
  (evil-signal-at-bob-or-eob count)
  (let ((sym (thing-at-point 'evil-symbol))
        (pos (point))
        break)
    (while (and sym
                (not (string-match "\\<" sym))
                (not break))
      (evil-backward-beginning 'evil-symbol 1)
      (when (equal pos (point)) (setq break t))
      (setq pos (point))
      (evil-signal-at-bob-or-eob count)
      (setq sym (thing-at-point 'evil-symbol))))
  )


;;;###autoload
(evil-define-motion evil-forward-symbol-end(count)
  "Move to the end of the COUNT-th next symbol."
  ;; :jump t
  :type exclusive
  (evil-signal-at-bob-or-eob count)
  (forward-evil-symbol count)

  ;; (let ((sym (thing-at-point 'evil-symbol)))
  ;;   (while (and sym (not (string-match "^\\<" sym)))
  ;;     (evil-forward-end 'evil-symbol 1)
  ;;     (setq sym (thing-at-point 'evil-symbol))
  ;;     )
  ;;   )
  )

;;;###autoload
(evil-define-motion evil-backward-symbol-end(count)
  "Move to the end of the COUNT-th next symbol."
  ;; :jump t
  :type exclusive
  (evil-signal-at-bob-or-eob count)
  (evil-backward-end 'symbol count)
  (let ((sym (thing-at-point 'evil-symbol)))
    (while (and sym (not (string-match "\\<" sym)))
      (evil-backward-end 'evil-symbol 1)
      (setq sym (thing-at-point 'evil-symbol))
      )
    )
  )

(provide 'conf-evil-symbol)
