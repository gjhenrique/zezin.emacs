(defun zezin-add-purposes ()
  (add-to-list 'purpose-user-mode-purposes '(ruby-mode . ruby))
  (add-to-list 'purpose-user-mode-purposes '(rspec-mode . rspec))
  (add-to-list 'purpose-user-mode-purposes '(web-mode . web))
  (add-to-list 'purpose-user-mode-purposes '(emacs-lisp-mode . elisp)))

(use-package window-purpose
  :config
  (progn
    (purpose-mode)
    (purpose-x-golden-ratio-setup)
    (purpose-x-kill-setup)
    (purpose-x-popwin-setup)
    (zezin-add-purposes)
    (add-to-list 'global-mode-string '(:eval (purpose--modeline-string)))
    (purpose-compile-user-configuration)))

(provide 'zezin-purpose)
;;; zezin-purpose.el ends here
