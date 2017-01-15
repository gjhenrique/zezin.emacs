(use-package helm
  :init
  (progn
    (setq helm-mode-fuzzy-match t
	  helm-display-header-line nil
	  helm-echo-input-in-header-line t
	  helm-split-window-in-side-p t)
    ;; hiding minibuffer
    (defun helm-hide-minibuffer-maybe ()
      (when (with-helm-buffer helm-echo-input-in-header-line)
	(let ((ov (make-overlay (point-min) (point-max) nil nil t)))
	  (overlay-put ov 'window (selected-window))
	  (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
				  `(:background ,bg-color :foreground ,bg-color)))
	  (setq-local cursor-type nil))))
    (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe))
  :config
  (helm-mode 1))

(use-package helm-ag
  :init
  (progn
    ;; from spacemacs
    (defun zezin-helm-do-ag-region-or-symbol (func &optional dir initial-text)
      "Search with `ag' with a default input."
      (cl-letf* (((symbol-value 'helm-ag-insert-at-point) 'symbol)
		 ;; make thing-at-point choosing the active region first
		 ((symbol-function 'this-fn) (symbol-function 'thing-at-point))
		 ((symbol-function 'thing-at-point)
		  (lambda (thing)
		    (or initial-text
			(let ((res (if (region-active-p)
				       (buffer-substring-no-properties
					(region-beginning) (region-end))
				     (this-fn thing))))
			  (when res (rxt-quote-pcre res)))))))
	(funcall func dir)))
    (defun helm-projectile-region-or-symbol ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol #'helm-projectile-ag))
    (cl-defun helm-do-ag-current-directory (&optional (dir default-directory))
      (interactive)
      (helm-do-ag default-directory))
    (defun helm-do-ag-current-directory-region-or-symbol ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol
       #'helm-do-ag-current-directory))
    (defun helm-do-ag-region-or-symbol ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol #'helm-do-ag))
    (defun helm-do-ag-use-package ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol #'helm-do-ag
					 zezin-dir
					 "\\(use-package "))))

(provide 'zezin-helm)
;;; zezin-helm.el ends here
