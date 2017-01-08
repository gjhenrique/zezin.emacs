(use-package js2-mode
  :init
  (progn
    (setq js2-basic-offset 2)
    (add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))))

(use-package tern
  :init
  (add-hook 'js2-mode-hook 'tern-mode))

(use-package company-tern
  :init
  (add-to-list 'company-backends 'company-tern))

(use-package jade)

(use-package json-mode)
(use-package web-beautify)

(with-eval-after-load 'flycheck
  (push 'js2-mode flycheck-global-modes)
  (push 'json-mode flycheck-global-modes))

(with-eval-after-load 'company
  (push 'company-tern company-backends))

(zezin-add-keybinding :language
		      ;; tern
		      `(("f" tern-find-definition)
			("j" tern-get-docs)
			;; web-beautify
			("a" web-beautify-js))
		      :map 'js2-mode-map)

(zezin-add-keybinding :language		      
		      `(("a" web-beautify-json))
		      :map 'json-mode)

;; keybindings
;; web-beautify

;; tern-find-definition
;; tern-rename
;; ter-get-docs


;; js2-mode
;; js2-refactor

;; mocha.el
;; jade?
;; skewer-mode?
;; livid-mode
;; company
;; company-tern
;; flycheck
;; helm
;; json-mode
;; json-snatcher
;; company-tern
;; tern
;; web-beautify

;; react-mode?

(provide 'zezin-javascript)
;;; zezin-javascript ends here
