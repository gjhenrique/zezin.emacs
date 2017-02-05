(use-package bundler)

(use-package rubocop
  :init
  (add-hook 'rubocop-mode 'ruby-mode-hook))

(use-package ruby-tools
  :init
  (add-hook 'ruby-mode-hook 'ruby-tools-mode))

(use-package robe
  :init
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package rake
  :init
  (setq rake-cache-file (concat zezin-cache-dir "rake.cache")))

(use-package rspec-mode
  :init
  (add-hook 'ruby-mode-hook 'rspec-enable-appropriate-mode)
  :config
  (progn
    (add-hook 'after-init-hook 'inf-ruby-switch-setup)
    (rspec-install-snippets)))

(use-package minitest)

(use-package goto-gem)

(use-package projectile-rails
  :init
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

(with-eval-after-load 'evil-matchit
  (add-hook #'ruby-mode-hook 'turn-on-evil-matchit-mode))

(with-eval-after-load 'flycheck
  (push 'ruby-mode flycheck-global-modes))

(with-eval-after-load 'company
  (push 'company-robe company-backends)
  (push 'ruby-mode company-dabbrev-code-modes))


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

(defmacro railsprojects-setup-project-dired (project-dir project-name)
  `(defun ,(railsprojects-function-project-name "railsprojects-project-dired-" project-name) ()
     (interactive)
     (dired ,project-dir)))

(defmacro railsprojects-setup-counsel-ag (project-dir project-name)
  `(progn
     (defun ,(railsprojects-function-project-name "railsprojects-counsel-ag-region-or-symbol-" project-name) ()
       (interactive)
       (counsel-ag-project-directory ,project-dir))
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

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.cap\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.podspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Puppetfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Appraisals\\'" . ruby-mode))

(zezin-add-keybinding :language
		      `(;; rspec
			("p" rspec-verify-all)
			("o" rspec-verify)
			("u" rspec-verify-method)
			("i" rspec-run-last-failed)
			("t" rspec-verify-single)
			("u" rspec-toggle-spec-and-target)
			("y" rspec-toggle-spec-and-target-find-example)

			;; minitest
			("q" minitest-verify-all)
			("w" minitest-verify)
			("e" minitest-verify-single)
			("c" minitest-rerun)

			;; rake: TODO

			;; robe
			("j" robe-doc)
			("z" robe-rails-refresh)
			("f" robe-jump)
			("x" robe-start)

			;; bundle
			("b" bundle-install)

			;; goto-gem
			("s" goto-gem)

			;; ruby-tools
			("m" ruby-tools-single-quote-string)
			("n" ruby-tools-to-double-quote-string)
			("v" ruby-tools-to-double-quote-string)

			;; projectile-rails
			;; Spacemacs <3
			;; Find files
			("da" projectile-rails-find-locale)
			("dc" projectile-rails-find-controller)
			("de" projectile-rails-find-environment)
			("df" projectile-rails-find-feature)
			("dh" projectile-rails-find-helper)
			("di" projectile-rails-find-initializer)
			("dj" projectile-rails-find-javascript)
			("dl" projectile-rails-find-lib)
			("dm" projectile-rails-find-model)
			("dn" projectile-rails-find-migration)
			("do" projectile-rails-find-log)
			("dp" projectile-rails-find-spec)
			("dr" projectile-rails-find-rake-task)
			("ds" projectile-rails-find-stylesheet)
			("dt" projectile-rails-find-test)
			("du" projectile-rails-find-fixture)
			("dv" projectile-rails-find-view)
			("dy" projectile-rails-find-layout)
			("d@" projectile-rails-find-mailer)
			;; Goto file
			("ac" projectile-rails-find-current-controller)
			("ad" projectile-rails-goto-schema)
			("ae" projectile-rails-goto-seeds)
			("ah" projectile-rails-find-current-helper)
			("aj" projectile-rails-find-current-javascript)
			("ag" projectile-rails-goto-gemfile)
			("am" projectile-rails-find-current-model)
			("an" projectile-rails-find-current-migration)
			("ap" projectile-rails-find-current-spec)
			("ar" projectile-rails-goto-routes)
			("as" projectile-rails-find-current-stylesheet)
			("at" projectile-rails-find-current-test)
			("au" projectile-rails-find-current-fixture)
			("av" projectile-rails-find-current-view)
			("az" projectile-rails-goto-spec-helper)
			("a." projectile-rails-goto-file-at-point)
			("aq" projectile-toggle-between-implementation-and-test))
		      :map 'ruby-mode-map) 

(provide 'zezin-ruby)
;;; zezin-ruby ends here
