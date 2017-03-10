(use-package elixir-mode)

(use-package alchemist)

(with-eval-after-load 'smartparens
  (sp-with-modes '(elixir-mode)
    (sp-local-pair
     "fn" "end"
     :when '(("SPC" "RET" "-" "("))
     :post-handlers '(:add spacemacs//elixir-do-end-close-action)
     :actions '(insert))
    (sp-local-pair
     "do" "end"
     :when '(("SPC" "RET"))
     :post-handlers '(:add spacemacs//elixir-do-end-close-action)
     :actions '(insert))))

(provide 'zezin-elixir)
