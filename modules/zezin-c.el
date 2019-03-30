(use-package counsel-gtags
  :commands
  counsel-gtags-dwim
  counsel-gtags-go-forward
  counsel-gtags-go-backward
  counsel-gtags-find-file)

(zezin-add-keybinding :language
                      `(("f" counsel-gtags-dwim)
                        ("s" counsel-gtags-go-forward)
                        ("a" counsel-gtags-go-backward)
                        ("g" counsel-gtags-find-file))
                      :map 'c-mode-map)

(zezin-add-keybinding :language
                      `(("f" counsel-gtags-dwim)
                        ("s" counsel-gtags-go-forward)
                        ("a" counsel-gtags-go-backward)
                        ("g" counsel-gtags-find-file))
                      :map 'c++-mode-map)

(provide 'zezin-c)
