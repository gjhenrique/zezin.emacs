(use-package elixir-mode
  :mode (("\\.ex\\'" . elixir-mode)
	 ("\\.exs$" . elixir-mode)))

(use-package erlang
  :mode (("\\.erl\\'" . erlang-mode)
         ("\\.hrl\\'" . erlang-mode)))

(use-package alchemist
  :after elixir
  :init
  (progn
    (let ((erlang-project (substitute-in-file-name "$HOME/Projects/erlang/")))
      (when (file-exists-p erlang-project)
        (setq alchemist-goto-erlang-source-dir erlang-project)))
    (let ((elixir-project (substitute-in-file-name "$HOME/Projects/elixir/")))
      (when (file-exists-p elixir-project)
        (setq alchemist-goto-elixir-source-dir elixir-project)))))

(use-package flycheck-credo
  :after (elixir-mode flycheck-mode)
  :config
  (flycheck-credo-setup))

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

(zezin-add-keybinding :language
                      `(("f" alchemist-goto-definition-at-point)
                        ("j" alchemist-help-search-at-point))
                      ;; add tests
                      :map 'elixir-mode-map)

(provide 'zezin-elixir)
