(use-package magit)

(use-package git-link
  :init
  (setq git-link-open-in-browser t)
  :config
  (add-to-list 'git-link-remote-alist
               '("code\\.locaweb\\.com\\.br" git-link-gitlab)))

(use-package evil-magit
  :after magit)

(use-package diff-hl
  :init
  (progn
    (setq diff-hl-side 'left)
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
			("q" smeargle-clear)
			("s" git-link)))

(provide 'zezin-git)
;;; zezin-git.el ends here
