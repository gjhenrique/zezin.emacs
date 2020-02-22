;; go get -u -v golang.org/x/tools/cmd/guru
;; go get -u github.com/nsf/gocode
;; go get -u github.com/rogpeppe/godef
;; go get -u golang.org/x/lint/golint
;; go get -u github.com/mdempsky/unconvert
;; go get -u honnef.co/go/tools/cmd/staticcheck

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

(use-package go-dlv
  :after go-mode)

(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))

(zezin-add-keybinding :language
                      `(("f" go-guru-definition))
                      :map 'go-mode-map)

(provide 'zezin-go)
;;; zezin-go ends here
