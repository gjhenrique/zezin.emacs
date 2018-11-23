(use-package counsel-gtags)

(zezin-add-keybinding :language
                      `(("j" counsel-gtags-dwim)
                        ("s" counsel-gtags-go-forward)
                        ("a" counsel-gtags-go-backward)
                        ("g" counsel-gtags-find-file))
                      :map 'c-mode-map)

(zezin-add-keybinding :language
                      `(("j" counsel-gtags-dwim)
                        ("s" counsel-gtags-go-forward)
                        ("a" counsel-gtags-go-backward)
                        ("g" counsel-gtags-find-file))
                      :map 'c++-mode-map)

(provide 'zezin-c)
;; counsel-gtags-find-definition
;; counsel-gtags-find-reference
;; counsel-gtags-find-symbol
;; counsel-gtags-find-file
;; counsel-gtags-go-backward
;; counsel-gtags-go-forward
;; counsel-gtags-create-tags
;; counsel-gtags-update-tags
;; counsel-gtags-dwin
