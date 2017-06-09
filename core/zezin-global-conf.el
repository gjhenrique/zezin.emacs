(setq gc-cons-threshold 50000000)

(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq load-prefer-newer t)
(setq initial-scratch-message nil)
(setq help-window-select t)

;;backups
(setq backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      backup-directory-alist `((".*" . ,zezin-backup-dir))
      auto-save-file-name-transforms `((".*" ,zezin-backup-dir t)))

;; Interlocking
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html
(setq create-lockfiles nil)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1)

(unless (bound-and-true-p custom-file)
  (setq custom-file (concat zezin-cache-dir "custom_file"))
  (when (file-exists-p custom-file)
    (load custom-file)))

(let ((emacs-directory "~/Projects/emacs"))
  (when (file-exists-p emacs-directory)
    (setq source-directory emacs-directory)))

(unless global-mode-string (setq global-mode-string '("")))

(use-package dash)

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-arguments (list "-l"))
  :config (when (memq window-system '(mac ns x nil))
	    (exec-path-from-shell-initialize)))

(use-package auto-package-update)
(use-package pcre2el)

;; Loading themes and fonts
(defun zezin-select-fonts-theme ()
  (interactive)
  (zezin-load-theme)
  (if (x-list-fonts "Source Code Pro")
      (set-frame-font "Source Code Pro 12")
    (message "Source Code Pro is not installed")))

(defun zezin-load-theme ()
  (use-package base16-theme
    :config
    (load-theme 'base16-default-dark t)))

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(select-frame frame)
		(zezin-select-fonts-theme)))
  (zezin-select-fonts-theme))

(defun sudo-save ()
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (ido-read-file-name "File:")))
    (write-file (concat "/sudo:root@localhost:" buffer-file-name))))

(provide 'zezin-global-conf)
;;; zezin-global-conf.el ends here
