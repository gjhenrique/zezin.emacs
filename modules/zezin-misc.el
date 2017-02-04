(use-package yaml-mode)

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

(provide 'zezin-misc)
;;; zezin-misc ends here
