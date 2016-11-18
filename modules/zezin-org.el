(use-package org-plus-contrib
  :init
  (progn
    (setq org-log-done t
	  org-imenu-depth 4
	  org-clock-clocked-in-display nil
	  org-imenu-depth 8
	  org-indent-mode t)))

(use-package evil-org)

(use-package org-bullets
  :defer t
  :init (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org-pomodoro
  :init
  (setq org-pomodoro-format "%s"))

(use-package htmlize)

(provide 'zezin-org)
;;; zezin-org ends here
