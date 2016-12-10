(use-package magit)

(use-package evil-magit
  :after magit)

(use-package diff-hl
  :init
  (progn
    (setq diff-hl-side 'right)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
  :config
  (diff-hl-mode))

(use-package git-messenger)

(use-package git-timemachine)

(use-package smeargle)

(zezin-add-keybinding :git
		      '(("f" magit-status)
			("j" magit-log-head)
			("k" magit-blame)
			("d" git-timemachine)
			("l" git-messenger:popup-message)
			("p" smeargle)
			("q" smeargle-clear)))

(provide 'zezin-git)
;;; zezin-git.el ends here
