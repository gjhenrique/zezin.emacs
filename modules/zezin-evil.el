(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  :bind (("C-i" . evil-jump-forward)))

(use-package evil-anzu
  :config
  (global-anzu-mode t))

(use-package evil-mc
  :if (not (daemonp))
  :config
  (evil-mc-mode 1))

(use-package evil-matchit)

(use-package evil-escape
  :config
  (evil-escape-mode))

(use-package evil-nerd-commenter)

(provide 'zezin-evil)
;;; zezin-evil.el ends here
