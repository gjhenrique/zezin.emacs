(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :config
  (progn
    (add-hook 'before-save-hook 'gofmt-before-save)))

(use-package company-go
  :after go-mode
  :init
  (setq company-go-show-annotation t))

(use-package go-guru
  :after go-mode)

(provide 'zezin-go)
