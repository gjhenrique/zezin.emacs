(setq zezin-frames
      '(((title . "Emacs - Primary"))
        ((title . "Emacs - Secondary"))
        ((title . "Emacs - Notes") (start-fn . zezin-start-notes-frame))
        ((title . "Emacs - Git") (start-fn . zezin-start-magit-frame))
        ((title . "Emacs - Compilation") (start-fn . zezin-start-compilation-frame))))

(setq zezin-work-file "$HOME/Life/clark.org")

(defun zezin-add-purposes ()
  (add-to-list 'purpose-user-mode-purposes '(ruby-mode . ruby))
  (add-to-list 'purpose-user-mode-purposes '(rspec-mode . spec))
  (add-to-list 'purpose-user-mode-purposes '(help-mode . help))
  (add-to-list 'purpose-user-mode-purposes '(web-mode . web))
  (add-to-list 'purpose-user-mode-purposes '(emacs-lisp-mode . elisp))
  (add-to-list 'purpose-user-mode-purposes '(js2-mode . javascript))
  (add-to-list 'purpose-user-mode-purposes '(js-mode . javascript))
  (add-to-list 'purpose-user-mode-purposes '(rjsx-mode . javascript))
  (add-to-list 'purpose-user-regexp-purposes '("^\\magit" . magit))

  ;; TODO: This is ugly
  (add-to-list 'purpose-user-mode-purposes '(yaml-mode . ruby)))

(defun zezin-disable-purpose-with-dired ()
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

(defun zezin-frame-title (frame)
  (cdr (assq 'title (frame-parameters frame))))

(defun zezin-frame-exists? (title)
  (member title
          (-map
           (lambda (frame) (zezin-frame-title frame))
           (frame-list))))

(defun zezin-make-new-frame (frame-config)
  (let ((title (assoc 'title frame-config)))
    (when (not (zezin-frame-exists? (cdr title)))
      (make-frame `(,title)))))

(defun zezin-start-frames ()
  (interactive)
  (-each zezin-frames 'zezin-make-new-frame))

(defun zezin-find-start-fn (frame-title)
  (cdr (assoc 'start-fn
              (-first
               (lambda (frame-config)
                 (string= (cdr (assoc 'title frame-config)) frame-title))
               zezin-frames))))

(defun zezin-find-note-file ()
  zezin-work-file)

(defun zezin-start-notes-frame (frame)
  (find-file (substitute-in-file-name (zezin-find-note-file)))
  (purpose-toggle-window-buffer-dedicated))

(defun zezin-start-magit-frame (frame)
  (switch-to-buffer (get-buffer-create "magit: purpose"))
  (purpose-toggle-window-purpose-dedicated))

(defun zezin-start-compilation-frame (frame)
  (switch-to-buffer (get-buffer-create "*compilation: purpose"))
  (compilation-mode)
  (purpose-toggle-window-purpose-dedicated))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let* ((title (zezin-frame-title frame))
                   (start-fn (zezin-find-start-fn title)))
              (when start-fn
                (select-frame frame)
                (funcall start-fn frame)))))

(use-package window-purpose
  :defer 15
  :config
  (progn
    (setq purpose-x-magit-single-conf
          (purpose-conf "magit-single"
                        :regexp-purposes '(("^magit" . magit))))

    (purpose-mode)
    (purpose-x-golden-ratio-setup)
    (purpose-x-kill-setup)

    (zezin-add-reusable-buffers "\\**compilation\\*")
    (zezin-add-reusable-buffers "\\magit*")
    (zezin-add-purposes)
    (zezin-disable-purpose-with-dired)

    (add-to-list 'global-mode-string '(:eval (purpose--modeline-string)))
    (purpose-compile-user-configuration)))

(provide 'zezin-purpose)
;;; zezin-purpose.el ends here
