(use-package org
  :ensure org-plus-contrib
  :init
  (progn
    (setq org-startup-indented t
	  org-log-done t
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

(zezin-add-keybinding :language
		      '(("i" org-agenda-open-link))
		      :map 'org-mode-map)

;; Blogging
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)))
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (string= lang "dot")))
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (setq org-html-htmlize-output-type 'css))


(provide 'zezin-org)
;;; zezin-org ends here
