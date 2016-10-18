(setq gc-cons-threshold 50000000)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq load-prefer-newer t)
(setq make-backup-files nil)
(setq initial-scratch-message nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(global-linum-mode)
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "M-e") nil)
(global-set-key (kbd "M-w") nil)
(global-set-key (kbd "M-f") nil)
(global-set-key (kbd "M-s") nil)

(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package auto-package-update)
(use-package pcre2el)

(provide 'zezin-global-conf)
;;; zezin-global-conf.el ends here
