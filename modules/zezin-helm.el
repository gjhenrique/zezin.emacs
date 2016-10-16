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


(provide 'zezin-helm)
;;; zezin-helm.el ends here
