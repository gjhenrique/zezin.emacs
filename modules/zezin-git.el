(use-package magit
  :commands (magit-status magit-log-head magit-blame))

(use-package forge
  :disabled
  :after magit)

(use-package git-link
  :commands git-link
  :init
  (setq git-link-open-in-browser t))

(use-package evil-magit
  :after (evil magit))

(use-package git-messenger
  :commands git-messenger:popup-message)

(use-package git-timemachine
  :commands git-timemachine)

(use-package smeargle
  :commands smeargle smeargle-clear)

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
