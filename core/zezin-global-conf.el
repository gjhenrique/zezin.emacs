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

(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(global-linum-mode)
(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1)

(unless (bound-and-true-p custom-file)
  (setq custom-file (concat zezin-cache-dir "custom_file")))

(unless global-mode-string (setq global-mode-string '("")))

(use-package dash)
(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package auto-package-update)
(use-package pcre2el)

(provide 'zezin-global-conf)
;;; zezin-global-conf.el ends here
