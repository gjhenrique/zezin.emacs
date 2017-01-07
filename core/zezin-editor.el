(use-package popwin
  :config
  (push '("*Help*" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
  (push '("*Backtrace*" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config))

(use-package ag)

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
  (global-aggressive-indent-mode 1))


(use-package window-purpose)
;;  :config
;;  (progn
;;  (purpose-mode)
;; set location
;; (purpose-x-golden-ratio-setup)
;; (add-to-list 'global-mode-string '(:eval (purpose--modeline-string)))))

(use-package projectile
  :init
  (setq projectile-sort-order 'recentf
	projectile-cache-file (concat zezin-cache-dir "projectile.cache")
	projectile-known-projects-file (concat zezin-cache-dir "projectile-bookmarks.eld")
	projectile-completion-system 'helm)
  :config
  (projectile-global-mode))

(use-package helm-projectile)

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
    (defengine stackoverflow
      "http://stackoverflow.com/search?q=%s")))

(use-package smart-mode-line
  :init
  (progn
    (line-number-mode 0)
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


;; custom modifications
(dolist (hook '(text-mode-hook
		org-mode-hook
		markdown-mode))
  (add-hook hook 'turn-on-flyspell))

;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(provide 'zezin-editor)
;;; zezin-editor.el ends here
