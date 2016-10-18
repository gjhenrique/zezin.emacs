(use-package helm
  :init
  (progn
    (setq helm-mode-fuzzy-match t
	  helm-prevent-escaping-from-minibuffer t
	  helm-display-header-line nil
	  helm-split-window-in-side-p t
	  helm-always-two-windows t
	  helm-echo-input-in-header-line t)

    ; hiding minibuffer
    (defun helm-hide-minibuffer-maybe ()
      (when (with-helm-buffer helm-echo-input-in-header-line)
	(let ((ov (make-overlay (point-min) (point-max) nil nil t)))
	  (overlay-put ov 'window (selected-window))
	  (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
				  `(:background ,bg-color :foreground ,bg-color)))
	  (setq-local cursor-type nil))))
    (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

    (push '("^\*helm.+\*$" :regexp t) popwin:special-display-config)
    (add-hook 'helm-after-initialize-hook (lambda ()
					    (popwin:display-buffer helm-buffer t)
					    (popwin-mode -1)))
    (add-hook 'helm-cleanup-hook (lambda () (popwin-mode 1))))
  :config
  (helm-mode 1)
  :bind (("M-f M-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 ("M-f b" . helm-mini)
	 :map helm-map
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-j" . helm-next-line)
	 ("C-k" . helm-previous-line)
	 ("C-h" . helm-find-files-up-one-level)))

(use-package helm-projectile
  :bind (("M-p M-d" . helm-projectile-find-dir)
	 ("M-p M-h" . helm-projectile)
	 ("M-p M-f" . helm-projectile-find-file)
	 ("M-p M-p" . helm-projectile-switch-project)
	 ("M-p M-b" . helm-projectile-switch-to-buffer)
	 ("M-p M-h" . helm-projectile)))

; searching
(use-package helm-ag
  :init
  (progn
					; from spacemacs
    (defun zezin-helm-do-ag-region-or-symbol (func &optional dir)
      "Search with `ag' with a default input."
      (cl-letf* (((symbol-value 'helm-ag-insert-at-point) 'symbol)
		 ;; make thing-at-point choosing the active region first
		 ((symbol-function 'this-fn) (symbol-function 'thing-at-point))
		 ((symbol-function 'thing-at-point)
		  (lambda (thing)
		    (let ((res (if (region-active-p)
				   (buffer-substring-no-properties
				    (region-beginning) (region-end))
				 (this-fn thing))))
		      (when res (rxt-quote-pcre res))))))
	(funcall func dir)))
    (defun helm-projectile-region-or-symbol ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol #'helm-projectile-ag))
    (cl-defun helm-do-ag-current-directory (&optional (dir default-directory))
      (interactive)
      (helm-do-ag dir))
    (defun helm-do-ag-current-directory-region-or-symbol ()
      (zezin-helm-do-ag-region-or-symbol
       '(lambda (dir) (zezin-helm-do-ag-current-directory dir))))
    (defun helm-do-ag-region-or-symbol ()
      (interactive)
      (zezin-helm-do-ag-region-or-symbol 'helm-do-ag)))
  :bind (("M-s M-a" . helm-projectile-ag)
	 ("M-s M-s" . helm-projectile-region-or-symbol)
	 ("M-s M-d" . helm-do-ag-current-directory)
	 ("M-s M-f" . helm-do-ag-current-directory-region-or-symbol)
	 ("M-s M-g" . helm-do-ag)
	 ("M-s M-r" . helm-do-ag-region-or-symbol)))

(provide 'zezin-helm)
;;; zezin-helm.el ends here
