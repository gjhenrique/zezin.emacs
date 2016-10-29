; core packages
(use-package popwin)
(use-package ag)

(use-package recentf)

(use-package projectile
  :init
  (setq projectile-sort-order 'recentf
	projectile-cache-file (concat zezin-cache-dir "projectile.cache")
	projectile-known-projects-file (concat zezin-cache-dir "projectile-bookmarks.eld"))
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :bind (:projectile
         ("d" . helm-projectile-find-dir)
	 ("f" . helm-projectile-find-file)
	 ("j" . helm-projectile-switch-project)
	 ("g" . helm-projectile-switch-to-buffer)
	 ("h" . helm-projectile)))

(global-set-key
 (zezin-prefix-select-key :buffer "a")
 #'kill-this-buffer)

(use-package undo-tree
  :init
  (progn
    (setq undo-tree-visualizer-timestamps t
	  undo-tree-visualizer-diff t))
  :config
  (global-undo-tree-mode)
  :bind (:editor ("u" . undo-tree-visualize)))

(use-package which-key
  :config
  (which-key-mode))

(use-package expand-region
  :bind(("M-w" . er/expand-region)))

(use-package smartparens
  :init
  (add-hook 'prog-mode-hook #'smartparens-mode))

(use-package highlight-parentheses
  :init
  (progn
    (add-hook 'prog-mode-hook #'highlight-parentheses-mode))
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'extra-bold))

(use-package flycheck
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode))

(use-package company
  :init
  (progn
    (setq company-idle-delay 0.5
	  company-tooltip-limit 10
	  company-minimum-prefix-length 2)
    (global-company-mode))
  :bind (:map company-active-map
	      ("<tab>" . company-complete-common-or-cycle)
	      ("<backtab>" . company-select-previous)))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package engine-mode
  :bind
  (:search ("k" . engine/search-google)
	   ("l" . engine/search-stackoverflow))
  :config
  (progn
    (engine-mode t)
    (defengine github
      "https://github.com/search?ref=simplesearch&q=%s")
    (defengine google
      "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")
    (defengine stackoverflow
      "http://stackoverflow.com/search?q=%s"))) 

(provide 'zezin-editor)
;;; zezin-editor.el ends here
