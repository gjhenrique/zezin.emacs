(use-package evil
  :config
  (evil-mode 1)
  :bind (("C-i" . evil-jump-forward)))

(use-package evil-anzu
  :config
  (global-anzu-mode t))

(use-package evil-matchit)

(use-package evil-escape
  :config
  (evil-escape-mode))

(use-package evil-nerd-commenter
  :bind (("M-c" . evilnc-comment-or-uncomment-lines)
         ("M-C" . evilnc-comment-or-uncomment-paragraphs)))

(provide 'zezin-evil)
;;; zezin-evil.el ends here
