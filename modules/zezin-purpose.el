(defun zezin-add-purposes ()
  (add-to-list 'purpose-user-mode-purposes '(ruby-mode . ruby))
  (add-to-list 'purpose-user-mode-purposes '(rspec-mode . spec))
  (add-to-list 'purpose-user-mode-purposes '(help-mode . help))
  (add-to-list 'purpose-user-mode-purposes '(web-mode . web))
  (add-to-list 'purpose-user-mode-purposes '(emacs-lisp-mode . elisp))
  (add-to-list 'purpose-user-mode-purposes '(js2-mode . javascript))
  (add-to-list 'purpose-user-mode-purposes '(react-mode . javascript))
  ;; TODO: This is ugly
  (add-to-list 'purpose-user-mode-purposes '(yaml-mode . ruby)))

(defun zezin-disable-dired ()
  (defalias 'dired-find-file-without-purpose
    (without-purpose-command #'dired-find-file))

  (with-eval-after-load 'dired
    (define-key dired-mode-map [remap dired-find-file] #'dired-find-file-without-purpose)))

(defun zezin-add-reusable-buffers (buffer-regex)
  (add-to-list 'display-buffer-alist
	       `(,buffer-regex
		 nil
		 (reusable-frames . t))))

(defun zezin-dedicate-purpose-window ()
  (let ((title (substring-no-properties
		(cdr (assoc 'title (frame-parameters))))))
    (purpose-set-window-purpose 'magit)))

(use-package window-purpose
  :config
  (progn
    (purpose-mode)
    (purpose-x-golden-ratio-setup)
    (purpose-x-kill-setup)
    (purpose-x-magit-single-on)

    (zezin-add-reusable-buffers "\\**compilation\\*")
    (zezin-add-reusable-buffers "\\*magit*")
    (zezin-add-purposes)
    (zezin-disable-dired)

    (add-to-list 'global-mode-string '(:eval (purpose--modeline-string)))
    (purpose-compile-user-configuration)))

(use-package ivy-purpose)

(provide 'zezin-purpose)
;;; zezin-purpose.el ends here
