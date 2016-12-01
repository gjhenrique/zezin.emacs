(use-package magit)

(use-package evil-magit
  :after magit)

(use-package diff-hl
  :init
  (progn
    (setq diff-hl-side 'right)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
  :config
  (diff-hl-margin-mode))

(provide 'zezin-git)
;;; zezin-git.el ends here
