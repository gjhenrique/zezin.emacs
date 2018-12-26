(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
	 ("\\.erb\\'" . web-mode))
  :init
  (setq-default css-indent-offset 2
		js-indent-level 2
		indent-tabs-mode nil
		web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2
		web-mode-attr-indent-offset 2
		web-mode-enable-auto-pairing nil))

(use-package emmet-mode
  :hook ((css-mode-hook . emmet-mode)
         (html-mode-hook . emmet-mode)
         (sass-mode-hook . emmet-mode)
         (scss-mode-hook . emmet-mode)
         (web-mode-hook . emmet-mode))
  :config
  (progn
    (evil-define-key 'insert emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
    (evil-define-key 'insert emmet-mode-keymap (kbd "<tab>") 'emmet-expand-line)
    (evil-define-key 'emacs emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
    (evil-define-key 'emacs emmet-mode-keymap (kbd "<tab>") 'emmet-expand-line)
    (evil-define-key 'hybrid emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
    (evil-define-key 'hybrid emmet-mode-keymap (kbd "<tab>") 'emmet-expand-line)))

(use-package sass-mode
  :mode ("\\.sass\\'" . sass-mode))

(use-package haml-mode
  :mode ("\\.hamlc?\\'" . haml-mode))

;; prelude
(with-eval-after-load 'smartparens
  (sp-with-modes '(web-mode)
    (sp-local-pair "%" "%"
		   :unless '(sp-in-string-p)
		   :post-handlers '(((lambda (&rest _ignored)
				       (just-one-space)
				       (save-excursion (insert " ")))
				     "SPC" "=" "#")))
    (sp-local-tag "%" "<% "  " %>")
    (sp-local-tag "=" "<%= " " %>")
    (sp-local-tag "#" "<%# " " %>")))


(with-eval-after-load 'flycheck
  (dolist (mode '(haml-mode
		  scss-mode
		  web-mode))
    (push mode flycheck-global-modes)))

(provide 'zezin-web)
;;; zezin-web ends here
