;; Multiple projects Ruby
(defun railsprojects-function-project-name (fun-name a)
  (intern (concat fun-name a)))

(defmacro railsprojects-setup-inf-ruby (project-dir project-name)
  `(cl-defun ,(railsprojects-function-project-name "railsprojects-inf-ruby-console-" project-name) (&optional environment)
     ;; TODO: Interactive with development as default
     (let ((environment (or environment "development")))
       (with-temp-buffer
	 (setq default-directory ,project-dir)
	 (inf-ruby-console-run (format "%s%s" "bundle exec rails console " environment) ,project-name)))))

(defmacro railsprojects-setup-magit (project-dir project-name)
  `(defun ,(railsprojects-function-project-name "railsprojects-magit-status-" project-name) ()
     (interactive)
     (magit-status ,project-dir)))

(defmacro railsprojects-setup-dired (project-dir project-name)
  `(defun ,(railsprojects-function-project-name "railsprojects-project-dired-" project-name) ()
     (interactive)
     (dired ,project-dir)))

(defmacro railsprojects-setup-counsel-ag (project-dir project-name)
  `(progn
     (defun ,(railsprojects-function-project-name "railsprojects-counsel-ag-region-or-symbol-" project-name) ()
       (interactive)
       (counsel-ag-directory ,project-dir))
     (defun ,(railsprojects-function-project-name "railsprojects-counsel-ag-" project-name) ()
       (interactive)
       (counsel-ag nil ,project-dir))))

(defmacro railsprojects-setup-projectile-rails (project-dir project-name)
  `(defun ,(railsprojects-function-project-name "railsprojects-projectile-rails-" project-name) (fun)
     (cl-letf
	 (((symbol-function 'projectile-rails-root) (lambda () ,project-dir))
	  ((symbol-function 'projectile-project-root) (lambda () ,project-dir))
	  ((symbol-function 'projectile-project-project-name) (lambda () ,project-name)))
       (funcall fun)
       (projectile-rails-find-controller))))

(defmacro railsprojects-setup-rails-project (project-dir project-name)
  `(progn
     (railsprojects-setup-inf-ruby ,project-dir ,project-name)
     (railsprojects-setup-magit ,project-dir ,project-name)
     (railsprojects-setup-counsel-ag ,project-dir ,project-name)
     (railsprojects-setup-dired ,project-dir ,project-name)
     (railsprojects-setup-projectile-rails ,project-dir ,project-name)))
