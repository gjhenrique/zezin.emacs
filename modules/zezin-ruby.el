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
  (add-hook 'ruby-mode-hook 'rspec-enable-appropriate-mode))

(use-package goto-gem)

(use-package projectile-rails
  :init
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

(with-eval-after-load 'popwin
  (push '("*rspec-compilation*" :dedicated t :position bottom :stick t :noselect t :height 0.4)
	popwin:special-display-config)
  (push '("*rake-compilation*" :dedicated t :position bottom :stick t :noselect t :height 0.4)
	popwin:special-display-config ))

(with-eval-after-load 'evil-matchit
  (add-hook #'ruby-mode-hook 'turn-on-evil-matchit-mode))

(with-eval-after-load 'flycheck
  (push 'ruby-mode flycheck-global-modes))

(with-eval-after-load 'company
  (push 'company-robe company-backends)
  (push 'ruby-mode company-dabbrev-code-modes))

(defun zezin-launch-rails-console (dir buffer-name &optional environment)
  (let ((environment (or environment "development")))
    (with-temp-buffer
      (setq default-directory dir)
      (inf-ruby-console-run (format "%s%s" "bundle exec rails console " environment) buffer-name))))

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
		      ;; rspec
		      `(("p" rspec-verify-all)
			("o" rspec-verify)
			("u" rspec-verify-method)
			("i" rspec-run-last-failed)
			("t" rspec-verify-single)
			("u" rspec-toggle-spec-and-target)
			("y" rspec-toggle-spec-and-target-find-example)
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
			("a" goto-gem-grep-gem)
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
			("dc" projectile-rails-find-current-controller)
			("dd" projectile-rails-goto-schema)
			("de" projectile-rails-goto-seeds)
			("dh" projectile-rails-find-current-helper)
			("dj" projectile-rails-find-current-javascript)
			("dg" projectile-rails-goto-gemfile)
			("dm" projectile-rails-find-current-model)
			("dn" projectile-rails-find-current-migration)
			("dp" projectile-rails-find-current-spec)
			("dr" projectile-rails-goto-routes)
			("ds" projectile-rails-find-current-stylesheet)
			("dt" projectile-rails-find-current-test)
			("du" projectile-rails-find-current-fixture)
			("dv" projectile-rails-find-current-view)
			("dz" projectile-rails-goto-spec-helper)
			("d." projectile-rails-goto-file-at-point)
			("dq" projectile-toggle-between-implementation-and-test))
		      :map 'ruby-mode-map)

(provide 'zezin-ruby)
;;; zezin-ruby ends here
