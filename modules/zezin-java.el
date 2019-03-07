(use-package meghanada)

(use-package meghanada
  :mode ("\\.java\\'" . java)
  :config
  (meghanada-install-server)
  (add-hook 'java-mode-hook
            (lambda ()
              (meghanada-mode t)))
  :commands
  (meghanada-mode))
