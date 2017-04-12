(use-package go-mode
  :config
  (progn
    (add-hook 'before-save-hook 'gofmt-before-save)))

(use-package company-go
  :init
  (setq company-go-show-annotation t))

(use-package go-guru)

(provide 'zezin-go)
