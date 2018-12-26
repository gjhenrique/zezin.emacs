;; Declare first to add the auto-mode-alist before javascript
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.es6\\'" . js2-mode))
  :init
  (progn
    (setq-default js2-strict-trailing-comma-warning nil)
    (setq-default js2-strict-missing-semi-warning nil)
    (setq-default js2-basic-offset 2)
    (setq-default js-switch-indent-offset 2)
    (add-hook 'js2-mode-hook 'js2-imenu-extras-mode)))

(use-package coffee-mode
  :mode ("\\.coffee" . coffee-mode)
  :config
  (setq indent-line-function 'javascript/coffee-indent
        evil-shift-width coffee-tab-width))

(use-package rjsx-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\(containers\\|components\\).+js\\'" . rjsx-mode))
    ;; https://emacs.stackexchange.com/questions/33536/how-to-edit-jsx-react-files-in-emacs
    (defadvice js-jsx-indent-line (after js-jsx-indent-line-after-hack activate)
      "Workaround sgml-mode and follow airbnb component style."
      (save-excursion
        (beginning-of-line)
        (if (looking-at-p "^ +\/?> *$")
            (delete-char sgml-basic-offset)))))

  :bind (:map rjsx-mode-map
              ("TAB" . rjsx-delete-creates-full-tag)))

(use-package indium
  :after js2-mode)

(use-package json-mode
  :commands json-mode
  :mode "\\.json\\'")

(use-package web-beautify
  :commands web-beautify-js web-beautify-json web-beautify-css)

(use-package handlebars-mode
  :mode "\\.hbs\\'")

(use-package prettier-js
  :hook (js2-mode prettier-js-mode)
  :init
    (setq prettier-js-args '(
                             "--trailing-comma" "es5"
                             "--single-quote" "true")))

(defun setup-tide-mode ()
  (interactive)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package tide
  :mode(("\\.ts\\'" . typescript-mode))
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . setup-tide-mode)))

(use-package eslintd-fix
  :hook (js2-mode . eslintd-fix-mode))

;; npm install -g eslint babel-eslint eslint-plugin-react
(with-eval-after-load 'flycheck
  (push 'js2-mode flycheck-global-modes)
  (push 'json-mode flycheck-global-modes)
  (push 'rjsx-mode flycheck-global-modes)

  (dolist (checker '(javascript-eslint javascript-standard))
    (flycheck-add-mode checker 'rjsx-mode)
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
  (add-hook #'rjsx-mode-hook #'zezin-use-eslint-from-node-modules)
  (add-hook #'js2-mode-hook #'zezin-use-eslint-from-node-modules))

(defvar zezin-js-keybindings
  '(("f" tern-find-definition)
    ("j" tern-get-docs)
    ("k" prettier-js)
    ("l" tern-get-type)))

(zezin-add-keybinding :language
                      `(,(append
                          zezin-js-keybindings
                          '(("a" web-beautify-js))))
                      :map 'js2-mode-map)

(zezin-add-keybinding :language
                      zezin-js-keybindings
                      :map 'rjsx-mode-map)

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
