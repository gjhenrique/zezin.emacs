(cl-defun zezin-region-or-symbol (&optional initial-text)
  (or initial-text
      (if (region-active-p)
          (buffer-substring-no-properties
           (region-beginning) (region-end))
        (thing-at-point 'symbol))))

(use-package smex
  :config
  (smex-initialize))

(use-package ivy
  :after ido
  :init
  (setq ivy-use-virtual-buffers 1
        ivy-height 20)
  :config
  (progn
    (ido-mode -1)
    (ivy-mode 1)))

(defun zezin-find-root-lib (folder lib-identifier)
  "Cut the folder of the last"
  (let ((directories (f-split folder)))
    (and (member lib-identifier directories)
         (apply 'f-join (-take
                         (+ (-elem-index lib-identifier directories) 2)
                         directories)))))

(defvar zezin-lib-directories '("gems" "elpa" "node_modules"))

(defun zezin-find-lib-folder (folder)
  (cl-some
   (lambda (lib) (zezin-find-root-lib folder lib))
   zezin-lib-directories))

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
        (counsel-ag-directory folder)))

    (defun counsel-fzf-read-dir ()
      (interactive)
      (let ((folder (file-name-directory (read-file-name "fzf in directory: "))))
        (counsel-fzf nil folder)))))

(use-package counsel-projectile
  :after (counsel projectile))

(use-package ivy-rich
  :defer 10
  :after (ivy counsel)
  :config
  (ivy-rich-mode))

(use-package swiper
  :commands (swiper swiper-region-or-symbol)
  :config
  (cl-defun swiper-region-or-symbol (&optional initial-text)
    (interactive)
    (let ((res (zezin-region-or-symbol initial-text)))
      (swiper res))))

(provide 'zezin-ivy)
;;; zezin-ivy.el ends here
