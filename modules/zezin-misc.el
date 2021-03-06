(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'" "\\.yml.example\\'" "\\.yml.erb\\'"))

(use-package markdown-mode
  :mode (("\\.markdown$" . markdown-mode)
         ("\\.md$"       . markdown-mode)))

(use-package nginx-mode
  :mode ("nginx\\.conf\\'" "/nginx/.+\\.conf\\'"))

(use-package restclient
  :mode ("\\.http\\'" . restclient-mode)
  :config
  (zezin-add-keybinding :language
            '(("f" restclient-http-send-current))
            :map 'restclient-mode-map))

(use-package company-restclient
  :after restclient
  :config
  (add-to-list 'company-backends 'company-restclient))

(use-package ob-restclient
  :after (org-plus-contrib restclient)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t))))

(use-package google-translate
  :commands google-translate-smooth-translate
  :init
  (progn
    (setq google-translate-translation-directions-alist '(("de" . "en") ("en" . "pt") ("pt" . "en") ("en" . "de"))
          google-translate-show-phonetic t
          google-translate-backend-method 'curl
          google-translate-pop-up-buffer-set-focus t)
    (cl-defun zezin-listen-german-word ()
      (interactive)
      (let ((text (or
                   (zezin-region-or-symbol)
                   (completing-read "Word: " nil))))
        (google-translate-listen-translation "de" text))))
  :config
  (require 'google-translate-smooth-ui))

;; Workaround for search failed. See https://github.com/atykhonov/google-translate/issues/52#issuecomment-481310626
(with-eval-after-load "google-translate-tk"
  (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

(use-package php-mode
  :mode ("\\.php\\'" . php-mode))

(use-package define-word
  :commands (define-word-at-point define-word))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package writegood-mode
  :hook ((markdown-mode . writegood-mode)
         (org-mode . writegood-mode)))

(use-package tramp
  :defer 5
  :init
  (setq tramp-default-method "ssh"))

(use-package elfeed
  :commands bjm/elfeed-load-db-and-open
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
  :after elfeed org
  :init
  (setq rmh-elfeed-org-files (list (expand-file-name "feeds.org" zezin-dir)))
  :config
  (elfeed-org))

(use-package systemd
  :mode ("\\.service\\'" . systemd-mode))

(use-package tldr
  :commands tldr)

(use-package groovy-mode
  :mode ("\\.g\\(?:ant\\|roovy\\|radle\\)\\'" "Jenkinsfile")
  :init
  (setq groovy-indent-offset 2))

(use-package terraform-mode
  :mode "\\.tf\\(vars\\)?\\'")

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package jenkins
  :commands jenkins
  :init
  (progn
    (setq jenkins-api-token (getenv "JENKINS_TOKEN"))
    (setq jenkins-url (getenv "JENKINS_URL"))
    (setq jenkins-username (getenv "JENKINS_USER"))))

(use-package esup
  :commands esup
  :init
  (progn
    (setq esup-user-init-file (file-truename "~/.emacs.d/init.el"))
    (setq esup-depth 1)))

(use-package all-the-icons
  :defer t)

(use-package strace-mode
  :mode "\\.strace\\'")

(use-package olivetti
  :commands olivetti-mode)

;; https://www.emacswiki.org/emacs/SqlBeautify
(defun sql-beautify-region (beg end)
  "Beautify SQL in region between beg and END."
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "anbt-sql-formatter" nil t)))

(defun sql-beautify-buffer ()
  "Beautify SQL in buffer."
  (interactive)
  (sql-beautify-region (point-min) (point-max)))


(provide 'zezin-misc)
;;; zezin-misc ends here
