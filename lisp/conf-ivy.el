

(require 'ivy-posframe)
;; display at `ivy-posframe-style'
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))


;; Different command can use different display function.
(setq ivy-posframe-height-alist '((swiper . 20)
				  (counsel-rg . 25)
                                  (t      . 30)))


(setq ivy-posframe-display-functions-alist
      '((swiper          . nil)
	(counsel-rg      . nil)
	(complete-symbol . ivy-posframe-display-at-point)
	(counsel-M-x     . nil)
	(dired-mode    .  ivy-posframe-display-at-window-center)
	(t               . ivy-posframe-display-at-window-center))
      )


(put 'ivy-posframe 'face-alias 'default)

(setq ivy-posframe-parameters
      '((left-fringe . 20)
        (right-fringe . 20)))

(defun vmacs-ivy-posframe-get-size ()
  "The default functon used by `ivy-posframe-size-function'."
  (list
   :height (min (- (frame-height) 4) (+ ivy-height 1))
   :width (min (round (- (frame-width) 12)) 130)
   :min-height (or ivy-posframe-min-height (+ ivy-height 1))
   :min-width (or ivy-posframe-min-width (round (* (frame-width) 0.62)))))

(setq ivy-posframe-size-function #'vmacs-ivy-posframe-get-size)



(setq ivy-height 25)
(setq ivy-fixed-height-minibuffer t)
(setq ivy-count-format "")

(setq ivy-virtual-abbreviate 'full) ; not only show buffer name,but path



(ivy-posframe-mode 1)





(provide 'conf-ivy)
