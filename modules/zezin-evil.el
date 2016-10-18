(use-package evil
  :config
  (evil-mode 1))

(use-package evil-anzu
  :config
  (global-anzu-mode t)) 

(use-package evil-nerd-commenter
  :bind (("M-c" . evilnc-comment-or-uncomment-lines)
	 ("M-C" . evilnc-comment-or-uncomment-paragraphs)))

(provide 'zezin-evil)
;;; zezin-evil.el ends here
