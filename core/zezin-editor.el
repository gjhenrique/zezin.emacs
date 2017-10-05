(use-package recentf
  :init
  (progn
    (add-hook 'find-file-hook (lambda () (unless recentf-mode
					   (recentf-mode)
					   (recentf-track-opened-file))))
    (setq recentf-save-file (concat zezin-cache-dir "recentf")
	  recentf-max-saved-items 1000)))

(use-package aggressive-indent
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(use-package projectile
  :init
  (setq projectile-sort-order 'recentf
	projectile-cache-file (concat zezin-cache-dir "projectile.cache")
	projectile-known-projects-file (concat zezin-cache-dir "projectile-bookmarks.eld")
	projectile-completion-system 'ivy)
  :config
  (projectile-global-mode))

(use-package avy
  :init
  (setq avy-all-windows 'all-frames)
  :config
  ;; spacemacs
  (defun zezin-avy-goto-url ()
    "Use avy to go to an URL in the buffer."
    (interactive)
    (avy--generic-jump "https?://" nil 'pre)))

(use-package undo-tree
  :init
  (progn
    (setq undo-tree-visualizer-timestamps t
	  undo-tree-visualizer-diff t))
  :config
  (global-undo-tree-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package expand-region)

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(use-package smartparens
  :init
  (progn
    (add-hook 'prog-mode-hook #'smartparens-mode))
  :config
  (progn
    (require 'smartparens-config)
    (show-smartparens-global-mode +1)))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package highlight-parentheses
  :init
  (progn
    (add-hook 'prog-mode-hook #'highlight-parentheses-mode))
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'extra-bold))

(use-package flycheck
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode))

(use-package flycheck-pos-tip
  :after flycheck
  :init
  (flycheck-pos-tip-mode))

(use-package company
  :init
  (progn
    (setq company-idle-delay 0.5
	  company-tooltip-limit 10
	  company-minimum-prefix-length 2)
    (global-company-mode)))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package engine-mode
  :config
  (progn
    (engine-mode t)
    (defengine github
      "https://github.com/search?ref=simplesearch&q=%s")
    (defengine google
      "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")
    (defengine duckduckgo
      "https://duckduckgo.com/?q=%s")
    (defengine stackoverflow
      "http://stackoverflow.com/search?q=%s")))

(use-package smart-mode-line
  :init
  (progn
    (setq sml/no-confirm-load-theme t
	  sml/theme 'respectful
	  rm-whitelist '("")))
  :config
  (progn
    ;; Changing the order of mode-line-misc-info (global-mode-string) with mode-line-format
    (require 'cl)
    (let ((misc-position (position 'mode-line-misc-info mode-line-format))
	  (mode-line-position (position 'mode-line-modes mode-line-format)))
      (when (> misc-position mode-line-position)
	(setq mode-line-format
	      (-insert-at mode-line-position
			  'mode-line-misc-info
			  (-remove-at misc-position mode-line-format)))))
    (sml/setup)))

(use-package yasnippet
  :config
  (progn
    (let ((custom-snippets-dir (format "%s%s" zezin-dir "snippets/custom")))
      (add-to-list 'yas-snippet-dirs custom-snippets-dir))
    (yas-global-mode 1)))

(use-package dumb-jump
  :init
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-force-searcher 'ag)
  :config
  (progn
    (defun dumb-jump-go-without-cvs ()
      (interactive)
      (let ((dumb-jump-ag-cmd "ag -U"))
        (dumb-jump-go)))
    (defun dumb-jump-go-prompt-without-cvs ()
      (interactive)
      (let ((dumb-jump-ag-cmd "ag -U"))
        (dumb-jump-go-prompt)))))

;; custom modifications
(dolist (hook '(text-mode-hook
		org-mode-hook
		markdown-mode))
  (add-hook hook 'turn-on-flyspell))

;; http://stackoverflow.com/questions/13981899/how-can-i-kill-all-buffers-in-my-emacs
(defun nuke-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows))

;; https://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs
(defun zezin-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun clipboard/get ()
  (with-temp-buffer
    (clipboard-yank)
    (buffer-substring-no-properties (point-min) (point-max))))

(defun zezin-go-to-file-in-clipboard ()
  "Go to file in the clipboard"
  (interactive)
  (let ((filename (string-trim (clipboard/get))))
    (if (file-exists-p filename)
        (ffap filename)
      (message "File %s not exists" filename))))

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))

(provide 'zezin-editor)
;;; zezin-editor.el ends here
