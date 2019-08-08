(use-package recentf
  :after ivy
  :hook (find-file . (lambda () (unless recentf-mode
                                  (recentf-mode)
                                  (recentf-track-opened-file))))
  :init
  (progn
    (setq recentf-save-file (concat zezin-cache-dir "recentf")
          recentf-max-saved-items 1000)))

(use-package projectile
  :init
  (setq projectile-sort-order 'recentf
        projectile-cache-file (concat zezin-cache-dir "projectile.cache")
        projectile-known-projects-file (concat zezin-cache-dir "projectile-bookmarks.eld")
        ;; Using .projectile file to remove files
        projectile-indexing-method 'hybrid
        projectile-completion-system 'ivy)
  :config
  (progn
    (projectile-mode)
    (projectile-register-project-type 'generic '() :compile "" :test "")))

(use-package avy
  ;; evil-integration loads it
  :after evil
  :defer 5
  :config
  ;; spacemacs
  (defun zezin-avy-goto-url ()
    "Use avy to go to an URL in the buffer."
    (interactive)
    (avy--generic-jump "https?://" nil 'pre)))

(use-package undo-tree
  :commands undo-tree-visualize
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t)
  :config
  (global-undo-tree-mode))

(use-package which-key
  :defer 5
  :config
  (which-key-mode))

(use-package expand-region
  :commands er/expand-region)

(use-package smooth-scrolling
  :defer 10
  :config
  (smooth-scrolling-mode 1))

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (progn
    (require 'smartparens-config)
    (show-smartparens-global-mode +1)))

(use-package beacon
  :defer 20
  :config
  (beacon-mode 1))

(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode)
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'extra-bold))

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package flycheck-pos-tip
  :after flycheck
  :init
  (flycheck-pos-tip-mode))

(use-package company
  :defer 15
  :init
  (setq company-idle-delay 0.5
        company-tooltip-limit 10
        company-minimum-prefix-length 2)
  :config
  (global-company-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package engine-mode
  :commands (engine/search-google engine/search-duckduckgo engine/search-github)
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
  :defer 3
  :init
  (progn
    (setq sml/no-confirm-load-theme t
          sml/theme 'respectful
          rm-whitelist '("")))
  :config
  (progn
    ;; Changing the order of mode-line-misc-info (global-mode-string) with mode-line-format
    (require 'cl)
    (require 'dash)
    (let ((misc-position (position 'mode-line-misc-info mode-line-format))
          (mode-line-position (position 'mode-line-modes mode-line-format)))
      (when (> misc-position mode-line-position)
        (setq mode-line-format
              (-insert-at mode-line-position
                          'mode-line-misc-info
                          (-remove-at misc-position mode-line-format)))))
    (sml/setup)))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (let ((custom-snippets-dir (format "%s%s" zezin-dir "snippets/custom")))
    (add-to-list 'yas-snippet-dirs custom-snippets-dir)))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package dumb-jump
  :commands
  dumb-jump-go
  dumb-jump-go-without-cvs
  dumb-jump-go-prompt
  dumb-jump-go-prompt-without-cvs
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

(defun zezin-clipboard/get ()
  (with-temp-buffer
    (clipboard-yank)
    (buffer-substring-no-properties (point-min) (point-max))))

(defun zezin-go-to-file-in-clipboard ()
  "Go to file in the clipboard"
  (interactive)
  (let ((filename (string-trim (zezin-clipboard/get))))
    (if (file-exists-p filename)
        (ffap filename)
      (message "File %s not exists" filename))))

(put 'dired-find-alternate-file 'disabled nil)

(use-package dired-x
  :ensure f
  :after dired
  :hook (dired-load-hook . (lambda () load "dired-x")))

(provide 'zezin-editor)
;;; zezin-editor.el ends here
