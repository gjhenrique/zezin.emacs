(cl-defun zezin-symbol-or-region (&optional initial-text)
  (or initial-text
      (if (region-active-p)
	  (buffer-substring-no-properties
	   (region-beginning) (region-end))
	(thing-at-point 'symbol))))

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers 1
	ivy-height 20)
  :config
  (progn
    (with-eval-after-load 'ido
      (ido-mode -1)
      (ivy-mode 1))))

(use-package smex
  :config
  (smex-initialize))

(use-package counsel
  :config
  (progn
    (cl-defun counsel-ag-directory (dir &optional initial-text)
      (interactive)
      (let ((res (zezin-region-or-symbol initial-text)))
	(counsel-ag res dir)))

    (defun counsel-ag-region-or-symbol-projectile ()
      (interactive)
      (counsel-ag-directory (projectile-project-root)))

    (defun counsel-ag-region-or-symbol-current-dir ()
      (interactive)
      (counsel-ag-directory default-directory))

    (defun counsel-ag-use-package ()
      (interactive)
      (counsel-ag-directory zezin-dir "use-package "))))

(use-package counsel-projectile
  :after counsel)

(use-package ivy-purpose)

(use-package swiper
  :config
  (cl-defun swiper-region-or-symbol (&optional initial-text)
    (interactive)
    (let ((res (zezin-symbol-or-region initial-text)))
      (swiper res))))

(provide 'zezin-ivy)
;;; zezin-ivy.el ends here
