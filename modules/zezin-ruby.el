(setq ruby-insert-encoding-magic-comment nil)

(use-package ruby-mode
  :mode (("\\.rb" . ruby-mode)
         ("\\.rake\\'" . ruby-mode)
         ("\\.god\\'" . ruby-mode)
         ("Rakefile\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("\\.ru\\'" . ruby-mode)
         ("Gemfile\\'" . ruby-mode)
         ("Guardfile\\'" . ruby-mode)
         ("Capfile\\'" . ruby-mode)
         ("\\.cap\\'" . ruby-mode)
         ("\\.thor\\'" . ruby-mode)
         ("\\.rabl\\'" . ruby-mode)
         ("Thorfile\\'" . ruby-mode)
         ("Vagrantfile\\'" . ruby-mode)
         ("\\.jbuilder\\'" . ruby-mode)
         ("Podfile\\'" . ruby-mode)
         ("\\.podspec\\'" . ruby-mode)
         ("Puppetfile\\'" . ruby-mode)
         ("Berksfile\\'" . ruby-mode)
         ("Appraisals\\'" . ruby-mode)))

(use-package bundler
  :commands (bundle-install bundle-open))

(use-package feature-mode
  :mode (("\\.feature\\'" . feature-mode)))

(use-package rubocop
  :hook (ruby-mode . rubocop-mode))

(use-package ruby-tools
  :hook (ruby-mode . ruby-tools-mode))

(use-package robe
  :hook (ruby-mode . robe-mode))

(use-package rake
  :defer t
  :init
  (setq rake-cache-file (concat zezin-cache-dir "rake.cache")))

(use-package rspec-mode
  :hook ((ruby-mode . rspec-enable-appropriate-mode)
         (after-init . inf-ruby-switch-setup))
  :config
  (rspec-install-snippets))

(use-package minitest
  :commands (minitest-verify-all minitest-verify minitest-verify-single minitest-rerun))

(use-package projectile-rails
  :after projectile
  :init
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

(with-eval-after-load 'flycheck
  (push 'ruby-mode flycheck-global-modes))

(with-eval-after-load 'company
  (push 'company-robe company-backends)
  (push 'ruby-mode company-dabbrev-code-modes))

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
                        ("z" robe-ask)
                        ("f" robe-jump)
                        ("x" robe-start)

                        ;; bundle
                        ("b" bundle-install)
                        ("s" bundle-open)

                        ;; rubocop
                        ("m" rubocop-autocorrect-current-file)
                        ("n" rubocop-autocorrect-project)

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
