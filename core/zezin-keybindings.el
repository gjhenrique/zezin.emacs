(use-package general)

(defconst zezin-prefix-keys
  #s(hash-table data (:buffer "j"
			      :ace "w"
                              :window "f"
                              :editor "g"
                              :projectile "h"
                              :search "d"
                              :git "s"
                              :language "k"
			      :perspective "a")))

(cl-defun zezin-add-keybinding (prefix keys &key
				       (map 'global)
				       &allow-other-keys)
  (apply #'general-define-key
	 :states '(normal visual insert emacs)
	 :prefix "SPC"
	 :non-normal-prefix "M-SPC"
	 :keymaps map
	 :infix (gethash prefix zezin-prefix-keys)
	 (-flatten keys)))

(zezin-add-keybinding :projectile
                      '(("d" counsel-projectile-find-dir)
                        ("f" counsel-projectile-find-file)
                        ("j" counsel-projectile-switch-project)
                        ("s" counsel-fzf)
                        ("g" counsel-projectile-switch-to-buffer)
                        ("l" projectile-find-file-dwim)
                        ("h" counsel-projectile)
			("a" projectile-compile-project)))

(zezin-add-keybinding :editor
                      '(("s" evilnc-comment-or-uncomment-lines)
                        ("a" evilnc-comment-or-uncomment-paragraphs)
                        ("j" evil-avy-goto-word-or-subword-1)
                        ("l" evil-avy-goto-line)
			("g" evil-avy-goto-char-2)
                        ("k" evil-avy-goto-url)
                        ("u" undo-tree-visualize)
                        ("t" zezin-go-to-file-in-clipboard)
			("h" counsel-imenu)
			("i" browse-url-at-point)
			("o" engine/search-google)
                        ("w" tldr)
			("e" bjm/elfeed-load-db-and-open)
                        ("," dumb-jump-go)
                        ("." dumb-jump-go-without-cvs)
                        ("z" dumb-jump-go-prompt)
                        ("x" dumb-jump-go-prompt-without-cvs)))

(zezin-add-keybinding :window
		      '(("k" zezin-alternate-buffer-another-window)
			("l" evil-window-right)
			("h" evil-window-left)
			("j" evil-window-down)
			("k" evil-window-up)
			("d" evil-window-delete)
			("g" zezin-toggle-maximize-buffer)
			("s" split-window-right-and-focus)
			("f" ace-window)
			("a" split-window-below-and-focus)))

;; Figure it out a way to reuse general-define-key
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "w" 'other-window)

(zezin-add-keybinding :search
                      '(("k" engine/search-duckduckgo)
                        ("l" engine/search-github)
			("j" counsel-projectile-ag)
                        ("f" counsel-ag-region-or-symbol-projectile)
			("d" counsel-ag)
                        ("s" counsel-ag-region-or-symbol-current-dir)
			("h" swiper)
			("g" swiper-region-or-symbol)
                        ("t" counsel-ag-region-or-symbol-read-dir)
			("r" counsel-ag-read-dir)
			("a" counsel-ag-use-package)
                        ("x" counsel-ag-read-lib)
                        ("c" counsel-ag-read-gem)
			("i" google-translate-smooth-translate)
			("u" define-word-at-point)
			("y" define-word)))

(zezin-add-keybinding :buffer
                      '(("f" counsel-find-file)
			("j" ivy-switch-buffer)
			("d" mode-line-other-buffer)
			("k" kill-this-buffer)
			("s" purpose-pop-buffer-same-window)))

(bind-keys :map company-active-map
           ("<tab>" . company-complete-common-or-cycle)
           ("<backtab>" . company-select-previous))

(bind-keys ("M-o" . er/expand-region)
	   ("M-x" . counsel-M-x))

(provide 'zezin-keybindings)
;;; zezin-keybindings.el ends here
