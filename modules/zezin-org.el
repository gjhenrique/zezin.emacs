(defun setup-org-capture ()
  (setq org-capture-templates
        '(("v" "Vocabulary" entry
           (file+headline "/home/guilherme/Life/anki/vocabulary.org" "Vocabulary")
           "\n** Item\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic (and reversed card)\n:ANKI_DECK: Vocabulary\n:END:\n%T\n*** Front\n %?\n\n*** Back\n %i\n "))))

(use-package org
  :ensure org-plus-contrib
  :mode "\\.rb\\'"
  :interpreter ("org" . org-mode)
  :init
  (progn
    (setup-org-capture)
    (setq org-startup-indented t
	      org-log-done t
	      org-imenu-depth 4
	      org-clock-clocked-in-display nil
	      org-imenu-depth 8
	      org-indent-mode t))
  :config
  (require 'org-agenda))

(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package anki-editor
  :init
  (setq anki-editor-create-decks t)
  :after org)

(use-package htmlize
  :defer t)

(zezin-add-keybinding :language
		      '(("i" org-agenda-open-link))
		      :map 'org-mode-map)


(provide 'zezin-org)
;;; zezin-org ends here
