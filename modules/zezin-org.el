(use-package org
  :ensure org-plus-contrib
  :mode "\\.rb\\'"
  :interpreter ("org" . org-mode)
  :init
  (progn
    (setq org-startup-indented t
	  org-log-done t
	  org-imenu-depth 4
	  org-clock-clocked-in-display nil
	  org-imenu-depth 8
	  org-indent-mode t)))

(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package anki-editor
  :after org)

(use-package htmlize
  :defer t)

(zezin-add-keybinding :language
		      '(("i" org-agenda-open-link))
		      :map 'org-mode-map)


(provide 'zezin-org)
;;; zezin-org ends here
