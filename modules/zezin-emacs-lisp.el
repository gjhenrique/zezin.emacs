(use-package ielm)

(use-package elisp-slime-nav
  :init
  (progn
    (add-hook #'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
    (add-hook #'ielm-mode-hook #'elisp-slime-nav-mode)))

(use-package eldoc
  :init
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

(use-package auto-compile
  :init
  (progn
    (setq auto-compile-display-buffer nil)
    (add-hook 'emacs-lisp-mode-hook 'auto-compile-mode)))

(with-eval-after-load 'smartparens
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil))

;; from kaushalmodi
(defvar zezin-fns-in-edebug nil
  "List of functions for which `edebug' is instrumented.")

(defconst zezin-fns-regexp (concat "(\\s-*"
                                   "\\(cl-\\)*"
                                   "\\(defun\\|defmacro\\|defsubst\\)"
                                   "\\**"
                                   "\\s-+"
                                   "\\(?1:\\(\\w\\|\\s_\\)+\\)\\_>") ; word or symbol char
  "Regexp to find defun or defmacro definition.")

(zezin-add-keybinding :language
		      '(("f" elisp-slime-nav-find-elisp-thing-at-point)
			("j" elisp-slime-nav-describe-elisp-thing-at-point))
		      :map 'elisp-slime-nav-mode-map)

(defun zezin-toggle-edebug ()
  (interactive)
  (save-excursion
    (re-search-backward zezin-fns-regexp)
    (let ((start (point))
          (fn (match-string 1))
          end
          selection)
      (forward-sexp 1)
      (setq end (point))
      (if (member fn zezin-fns-in-edebug)
          ;; If the function is already being edebugged, uninstrument it
	  (progn
            (setq zezin-fns-in-edebug (delete fn zezin-fns-in-edebug))
            (eval-buffer)
            (setq-default eval-expression-print-length 12)
            (setq-default eval-expression-print-level  4)
            (message "Edebug disabled: %s" fn))
        ;; If the function is not being edebugged, instrument it
        (save-restriction
          (narrow-to-region start end)
          (add-to-list 'zezin-fns-in-edebug fn)
          (setq-default eval-expression-print-length nil)
          (setq-default eval-expression-print-level  nil)
          (edebug-defun)
          (message "Edebug: %s" fn))))))

(provide 'zezin-emacs-lisp)
;;; zezin-emacs-lisp.el ends here
