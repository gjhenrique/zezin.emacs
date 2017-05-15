(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml.example\\'" . yaml-mode)))

(use-package markdown-mode)

(use-package nginx-mode)

;; restclient
(use-package restclient
  :config
  (zezin-add-keybinding :language
			'(("f" restclient-http-send-current))
			:map 'restclient-mode-map))

(use-package company-restclient
  :config
  (add-to-list 'company-backends 'company-restclient))

(use-package ob-restclient
  :after org-plus-contrib
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t))))

(use-package google-translate
  :init
  (setq google-translate-translation-directions-alist '(("en" . "pt") ("pt" . "en"))
	google-translate-show-phonetic t
	google-translate-pop-up-buffer-set-focus t)
  :config
  (require 'google-translate-smooth-ui))

(use-package asp-mode
  :ensure nil)

(use-package define-word)

(use-package docker)
(use-package dockerfile-mode)

(use-package writegood-mode)

(provide 'zezin-misc)
;;; zezin-misc ends here
