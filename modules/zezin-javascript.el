(use-package js2-mode
  :init
  (progn
    (setq-default js2-basic-offset 2
		  js2-strict-trailing-comma-warning nil)
    (add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))))

;; react-mode activation
(progn
  (setq react-mode-map (make-sparse-keymap))
  (define-derived-mode react-mode web-mode "react")
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . react-mode))
  (add-to-list 'auto-mode-alist '("\\.react.js\\'" . react-mode))
  (add-to-list 'auto-mode-alist '("\\index.android.js\\'" . react-mode))
  (add-to-list 'auto-mode-alist '("\\index.ios.js\\'" . react-mode))
  (add-to-list 'magic-mode-alist '("/\\*\\* @jsx React\\.DOM \\*/" . react-mode))
  (add-to-list 'magic-mode-alist '("^import React" . react-mode)))

(use-package tern
  :init
  (add-hook 'js2-mode-hook 'tern-mode)
  (add-hook 'react-mode-hook 'tern-mode))

(use-package company-tern
  :init
  (add-to-list 'company-backends 'company-tern))

(use-package jade)
(use-package json-mode)
(use-package web-beautify)

;; npm install -g eslint babel-eslint eslint-plugin-react
(with-eval-after-load 'flycheck
  (push 'js2-mode flycheck-global-modes)
  (push 'json-mode flycheck-global-modes)
  (push 'react-mode flycheck-global-modes)

  (dolist (checker '(javascript-eslint javascript-standard))
    (flycheck-add-mode checker 'react-mode)
    (flycheck-add-mode checker 'js2-mode))

  (defun zezin-use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
		  (or (buffer-file-name) default-directory)
		  "node_modules"))
	   (global-eslint (executable-find "eslint"))
	   (local-eslint (expand-file-name "node_modules/.bin/eslint"
					   root))
	   (eslint (if (file-executable-p local-eslint)
		       local-eslint
		     global-eslint)))
      (setq-local flycheck-javascript-eslint-executable eslint)))
  (add-hook #'react-mode-hook #'zezin-use-eslint-from-node-modules)
  (add-hook #'js2-mode-hook #'zezin-use-eslint-from-node-modules))

(defvar zezin-js-keybindings
  '(("f" tern-find-definition)
    ("j" tern-get-docs)
    ("l" tern-get-type)))

(zezin-add-keybinding :language
		      `(,(append
			  zezin-js-keybindings
			  '(("a" web-beautify-js))))
		      :map 'js2-mode-map)

(zezin-add-keybinding :language
		      zezin-js-keybindings
		      :map 'react-mode-map)

(zezin-add-keybinding :language
		      `(("a" web-beautify-json))
		      :map 'json-mode)

;; mocha.el
;; jade?
;; skewer-mode?
;; livid-mode
;; json-snatcher
;; flycheck

(provide 'zezin-javascript)
;;; zezin-javascript ends here
