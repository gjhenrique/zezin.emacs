(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml.example\\'" . yaml-mode)))

(use-package markdown-mode)

(use-package nginx-mode)

(use-package csharp-mode)

(use-package realgud)

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
  (setq google-translate-translation-directions-alist '(("de" . "en") ("en" . "pt") ("pt" . "en") ("en" . "de"))
	google-translate-show-phonetic t
	google-translate-pop-up-buffer-set-focus t)
  :config
  (require 'google-translate-smooth-ui))

(use-package asp-mode
  :ensure nil)

(use-package php-mode)

(use-package define-word)

(use-package docker)
(use-package dockerfile-mode)

(use-package writegood-mode)

(use-package elfeed
  :bind (:map elfeed-search-mode-map
	      ("q" . bjm/elfeed-save-db-and-bury))
  ;; elfeed-db-directory 
  :init
  (setq-default elfeed-search-filter "@1-week-ago +unread +mustread")
  (defun bjm/elfeed-load-db-and-open ()
    "Wrapper to load the elfeed db from disk before opening"
    (interactive)
    (elfeed-db-load)
    (elfeed)
    (elfeed-search-update--force))

  (defun bjm/elfeed-save-db-and-bury ()
    "Wrapper to save the elfeed db to disk before burying buffer"
    (interactive)
    (elfeed-db-save)
    (quit-window)))

(use-package elfeed-org
  :init
  (setq rmh-elfeed-org-files (list (expand-file-name "feeds.org" zezin-dir)))
  :config
  (elfeed-org))

(use-package el-pocket
  :config
  (el-pocket-load-auth))

(use-package systemd)

(use-package tldr)

(use-package atomic-chrome
  :init
  (progn
    (define-derived-mode atomic-chrome-mode markdown-mode "AtomicChrome")
    (setq atomic-chrome-default-major-mode 'atomic-chrome-mode)
    (setq atomic-chrome-buffer-open-style 'full))
  :config
  (atomic-chrome-start-server))

(provide 'zezin-misc)
;;; zezin-misc ends here
