(cl-defun zezin-region-or-symbol (&optional initial-text)
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

(defun zezin-find-root-lib (folder lib-identifier)
  "Cut the folder of the last"
  (let ((directories (f-split folder)))
    (and (member lib-identifier directories)
         (apply 'f-join (-take
                         (+ (-elem-index lib-identifier directories) 2)
                         directories)))))

(defun zezin-find-lib-folder (folder)
  (zezin-find-root-lib default-directory "gems"))

(defun zezin-counsel-fzf-dir ()
  (or
   (zezin-find-lib-folder default-directory)
   default-directory))

(use-package counsel
  :init
  (setq counsel-fzf-cmd (substitute-in-file-name "$HOME/.fzf/bin/fzf -f %s"))
  (setq counsel-fzf-dir-function 'zezin-counsel-fzf-dir)

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

    (defun counsel-ag-read-lib ()
      (interactive)
      (let ((folder (zezin-find-lib-folder default-directory)))
        (counsel-ag-directory folder)))

    (defun counsel-ag-read-gem (gem-name)
      (interactive (list (completing-read "Bundled gem: " (bundle-list-gems-cached))))
      (let ((gem-location (bundle-gem-location gem-name)))
        (counsel-ag-directory gem-location)))

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
