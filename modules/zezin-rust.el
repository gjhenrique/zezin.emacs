(use-package rust-mode
  :mode "\\.rs\\'"
  :init
  (setq rust-format-on-save t))

(use-package racer
  :hook (rust-mode . racer-mode))

(use-package company-racer
  :after (racer company)
  :config
  (add-to-list 'company-backends 'company-racer))

(use-package flycheck-rust
  :commands flycheck-rust-setup
  :after (flycheck rust-mode)
  :hook ((flycheck-mode . flycheck-rust-setup)))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(zezin-add-keybinding :language
                      `(("f" racer-find-definition)
                        ("j" racer-describe)
                        ("g" racer-describe-tooltip))
                      :map 'rust-mode-map)

(provide 'zezin-rust)
;;; zezin-rust ends here
