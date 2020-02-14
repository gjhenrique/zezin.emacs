(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq load-prefer-newer t)
(setq initial-scratch-message nil)
(setq help-window-select t)
(setq column-number-mode t)
(setq x-alt-keysym 'meta)

(setq source-directory (substitute-in-file-name "$HOME/Projects/c/emacs/src"))

;;backups
(setq backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      backup-directory-alist `((".*" . ,zezin-backup-dir))
      auto-save-file-name-transforms `((".*" ,zezin-backup-dir t)))

(setq frame-title-format "%b")

;; Interlocking
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html
(setq create-lockfiles nil)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1)

;; Accept UTF-8 as utf-8
(define-coding-system-alias 'UTF-8 'utf-8)

(unless (bound-and-true-p custom-file)
  (setq custom-file (concat zezin-cache-dir "custom_file"))
  (when (file-exists-p custom-file)
    (load custom-file)))

(let ((emacs-directory "~/Projects/emacs"))
  (when (file-exists-p emacs-directory)
    (setq source-directory emacs-directory)))

;; http://ergoemacs.org/emacs/emacs_tabs_space_indentation_setup.html
(global-set-key (kbd "TAB") (lambda () (interactive) (insert "\t")))
(setq-default tab-width 4)

(use-package dash)
(use-package pcre2el :defer t)

(use-package auto-package-update
  :commands auto-package-update-now)

(use-package exec-path-from-shell
  :defer 2
  :init
  (setq exec-path-from-shell-arguments (list "-l"))
  :config (when (memq window-system '(mac ns x nil))
            (exec-path-from-shell-initialize)))

(setq zezin-font-size (if zezin-4k-display 14 11))

;; Loading themes and fonts
(defun zezin-select-fonts-theme ()
  (interactive)
  (zezin-load-theme)
  (if (and window-system (x-list-fonts "Source Code Pro"))
      (set-frame-font (concat "Source Code Pro " (number-to-string zezin-font-size)))
    (message "Source Code Pro is not installed")))

(defun zezin-load-light-theme ()
  (interactive)
  (load-theme 'doom-one-light))

(defun zezin-load-dark-theme ()
  (interactive)
  (load-theme 'doom-vibrant))

(defun zezin-load-theme ()
  (use-package doom-themes
    :config
    (zezin-load-dark-theme)))

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
