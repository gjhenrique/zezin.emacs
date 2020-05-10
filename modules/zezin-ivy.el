(cl-defun zezin-region-or-symbol (&optional initial-text)
  (or initial-text
      (if (region-active-p)
          (buffer-substring-no-properties
           (region-beginning) (region-end))
        (thing-at-point 'symbol))))

(use-package smex
  :commands (smex smex-major-mode-commands)
  :config
  (smex-initialize))

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20)
  :config
  (progn
    (require 'ido)
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
    (cl-defun counsel-rg-directory (dir &optional initial-text)
      (interactive)
      (let ((res (zezin-region-or-symbol initial-text)))
        (counsel-rg res dir "--hidden")))

    (defun counsel-rg-region-or-symbol-projectile ()
      (interactive)
      (counsel-rg-directory (projectile-project-root)))

    (defun counsel-rg-region-or-symbol-current-dir ()
      (interactive)
      (counsel-rg-directory default-directory))

    (defun counsel-rg-use-package ()
      (interactive)
      (counsel-rg-directory zezin-dir "use-package "))

    (defun counsel-rg-read-dir ()
      (interactive)
      (let ((folder (file-name-directory (read-file-name "ag in directory: "))))
        (counsel-rg nil folder)))

    (defun counsel-rg-read-lib ()
      (interactive)
      (let ((folder (zezin-find-lib-folder default-directory)))
        (counsel-rg-directory folder)))

    (defun counsel-rg-read-gem (gem-name)
      (interactive (list (completing-read "Bundled gem: " (bundle-list-gems-cached))))
      (let ((gem-location (bundle-gem-location gem-name)))
        (counsel-rg-directory gem-location)))

    (defun counsel-rg-region-or-symbol-read-dir ()
      (interactive)
      (let ((folder (file-name-directory (read-file-name "ag in directory: "))))
        (counsel-rg-directory folder)))

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
