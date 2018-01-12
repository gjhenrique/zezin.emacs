(cl-defun zezin-region-or-symbol (&optional initial-text)
  (or initial-text
      (if (region-active-p)
	  (buffer-substring-no-properties
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
  :init
  (setq counsel-fzf-cmd (substitute-in-file-name "$HOME/.fzf/bin/fzf -f %s"))
  (setq counsel-fzf-dir-function (lambda () default-directory))

  :config
  (progn
    (cl-defun counsel-ag-directory (dir &optional initial-text)
      (interactive)
      (let ((res (zezin-region-or-symbol initial-text)))
        (counsel-ag res dir "--hidden")))

    (defun counsel-ag-region-or-symbol-projectile ()
      (interactive)
      (counsel-ag-directory (projectile-project-root)))

    (defun counsel-ag-region-or-symbol-current-dir ()
      (interactive)
      (counsel-ag-directory default-directory))

    (defun counsel-ag-use-package ()
      (interactive)
      (counsel-ag-directory zezin-dir "use-package "))

    (defun counsel-ag-read-dir ()
      (interactive)
      (let ((folder (file-name-directory (read-file-name "ag in directory: "))))
	(counsel-ag nil folder)))

    (defun counsel-ag-region-or-symbol-read-dir ()
      (interactive)
      (let ((folder (file-name-directory (read-file-name "ag in directory: "))))
        (counsel-ag-directory folder)))))

(use-package counsel-projectile
  :after counsel)

(use-package ivy-rich
  :after ivy
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :config
  (cl-defun swiper-region-or-symbol (&optional initial-text)
    (interactive)
    (let ((res (zezin-region-or-symbol initial-text)))
      (swiper res))))

(provide 'zezin-ivy)
;;; zezin-ivy.el ends here
