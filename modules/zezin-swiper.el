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

(use-package counsel)

(use-package counsel-projectile
  :after counsel
  :init
  (progn
    (defun counsel-ag-directory (dir &optional initial-text)
      (interactive)
      (let ((res
	     (or initial-text
		 (if (region-active-p)
		     (buffer-substring-no-properties
		      (region-beginning) (region-end))
		   (thing-at-point 'symbol)))))
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

(use-package ivy-purpose)

(use-package swiper)

(provide 'zezin-swiper)
;;; zezin-swiper.el ends here
