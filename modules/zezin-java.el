(use-package lsp-java
  :mode ("\\.java\\'" . java)
  :config
  (add-hook 'java-mode-hook #'lsp))

(use-package scala-mode
  :mode ("\\.scala\\'" . scala-mode))
