(use-package evil
  :init
  (progn
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil))
  :config
  (evil-mode 1))

(use-package evil-anzu
  :after evil
  :config
  (global-anzu-mode t))

(use-package evil-multiedit
  :bind
  (:map evil-visual-state-map
        ("M-c" . evil-multiedit-toggle-marker-here))
  :config
  (evil-multiedit-default-keybinds))

(use-package evil-matchit
  :defer 4
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode))

(use-package evil-nerd-commenter
  :commands (evilnc-comment-or-uncomment-lines evilnc-comment-or-uncomment-paragraphs))

(provide 'zezin-evil)
;;; zezin-evil.el ends here
