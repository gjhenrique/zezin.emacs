(use-package elixir-mode)

(use-package alchemist
  :init
  (let ((elixir-project (substitute-in-file-name "$HOME/Projects/elixir/")))
    (when (file-exists-p elixir-project)
      (setq alchemist-goto-elixir-source-dir elixir-project))))

(use-package flycheck-credo
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(flycheck-credo-setup))
    (add-hook 'elixir-mode-hook 'flycheck-mode)))

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
