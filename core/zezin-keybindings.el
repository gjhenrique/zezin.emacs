(use-package general
  :after evil)

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

(defvar zezin-show-keybindings nil)

(cl-defun zezin-hi (prefix keys &key
                           (map 'global)
                           &allow-other-keys)
  (if zezin-show-keybindings
      (progn
        )
    (message "Map -- %s -- %s" map prefix)
    (-each keys (lambda (key)
                  (message "%s %s - %s"
                           (gethash prefix zezin-prefix-keys) (car key) (car (cdr key)))))))

(advice-add #'zezin-add-keybinding :after #'zezin-hi)

(zezin-add-keybinding :projectile
                      '(("d" counsel-projectile-find-dir)
                        ("f" counsel-projectile-find-file)
                        ("j" counsel-projectile-switch-project)
                        ("s" counsel-fzf)
                        ("x" counsel-fzf-read-dir)
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
                        ("k" zezin-avy-goto-url)
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
                        ("f" counsel-rg-region-or-symbol-projectile)
                        ("d" counsel-rg)
                        ("s" counsel-rg-region-or-symbol-current-dir)
                        ("h" swiper)
                        ("g" swiper-region-or-symbol)
                        ("t" counsel-rg-region-or-symbol-read-dir)
                        ("r" counsel-rg-read-dir)
                        ("a" counsel-rg-use-package)
                        ("x" counsel-rg-read-lib)
                        ("c" counsel-rg-read-gem)
                        ("i" google-translate-smooth-translate)
                        ("o" zezin-listen-german-word)
                        ("u" define-word-at-point)
                        ("y" define-word)))

(zezin-add-keybinding :buffer
                      '(("f" counsel-find-file)
                        ("j" ivy-switch-buffer)
                        ("d" mode-line-other-buffer)
                        ("k" kill-this-buffer)
                        ("s" purpose-pop-buffer-same-window)))

(zezin-add-keybinding :git
                      '(("f" magit-status)
                        ("j" magit-log-head)
                        ("k" magit-blame-addition)
                        ("d" git-timemachine)
                        ("l" git-messenger:popup-message)
                        ("p" smeargle)
                        ("q" smeargle-clear)
                        ("s" git-link)))

(with-eval-after-load 'company
  (bind-keys :map company-active-map
             ("<tab>" . company-complete-common-or-cycle)
             ("<backtab>" . company-select-previous)))

(bind-keys ("M-o" . er/expand-region)
           ("M-x" . counsel-M-x))

(provide 'zezin-keybindings)
;;; zezin-keybindings.el ends here
