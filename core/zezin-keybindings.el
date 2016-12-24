(use-package general)

(defconst zezin-prefix-keys
  #s(hash-table data (:buffer "j"
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
                      '(("d" helm-projectile-find-dir)
                        ("f" helm-projectile-find-file)
                        ("j" helm-projectile-switch-project)
                        ("g" helm-projectile-switch-to-buffer)
                        ("h" helm-projectile)
			("a" projectile-compile-project)))

(zezin-add-keybinding :editor
                      '(("s" evilnc-comment-or-uncomment-lines)
                        ("a" evilnc-comment-or-uncomment-paragraphs)
                        ("j" evil-avy-goto-char)
                        ("l" evil-avy-goto-line)
                        ("k" evil-avy-goto-url)
                        ("u" undo-tree-visualize)
			("h" helm-imenu)))

(zezin-add-keybinding :window
                      '(("f" ace-window)
                        ("k" zezin-alternate-buffer-another-window)
                        ("l" evil-window-right)
                        ("h" evil-window-left)
                        ("j" evil-window-down)
                        ("k" evil-window-up)
                        ("d" evil-window-delete)
                        ("g" zezin-toggle-maximize-buffer)
                        ("s" split-window-right-and-focus)
                        ("a" split-window-below-and-focus)))

(zezin-add-keybinding :search
                      '(("k" engine/search-google)
                        ("l" engine/search-github)
                        ("j" helm-projectile-ag)
                        ("s" helm-projectile-region-or-symbol)
                        ("d" helm-do-ag-current-directory)
                        ("f" helm-do-ag-current-directory-region-or-symbol)
                        ("g" helm-do-ag)
                        ("h" helm-do-ag-region-or-symbol)))

(zezin-add-keybinding :buffer
                      '(("f" helm-find-files)
                        ("j" helm-mini)
			("d" switch-to-previous-buffer)
			("k" kill-this-buffer)))

(bind-keys :map company-active-map
           ("<tab>" . company-complete-common-or-cycle)
           ("<backtab>" . company-select-previous))

(bind-keys ("M-w" er/expand-region))

;; helm
(bind-keys ("M-x" . helm-M-x)
           :map helm-map
           ("<tab>" . helm-execute-persistent-action)
           ("C-j" . helm-next-line)
           ("C-k" . helm-previous-line)
           ("C-h" . helm-find-files-up-one-level))

(provide 'zezin-keybindings)
;;; zezin-keybindings.el ends here
