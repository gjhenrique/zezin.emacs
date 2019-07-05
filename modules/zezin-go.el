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

(zezin-add-keybinding :language
                      `(("f" go-guru-definition))
                      :map 'go-mode-map)

(provide 'zezin-go)
;;; zezin-go ends here
