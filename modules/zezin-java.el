(use-package lsp-java
  :mode ("\\.java\\'" . java)
  :config
  (add-hook 'java-mode-hook #'lsp))

(use-package scala-mode
  :mode ("\\.scala\\'" . scala-mode))

;; (USE-package meghanada
;;   :init
;;   (setq meghanada-debug t)
;;   :mode ("\\.java\\'" . java)
;;   :config
;;   (meghanada-install-server)
;;   (add-hook 'java-mode-hook
;;             (lambda ()
;;               (meghanada-mode t))))


;; meghanada-ping
;; meghanada-kill-running-process
;; meghanada-clear-cache
;; meghanada-optimize-import
;; meghanada-import-all
;; meghanada-import-at-point
;; meghanada-local-variable
;; meghanada-compile-file
;; meghanada-compile-project
;; meghanada-switch-test-case
;; meghanada-run-junit-class
;; meghanada-run-junit-test-case
;; meghanada-debug-junit-class
;; meghanada-debug-junit-test-case
;; meghanada-run-junit-recent
;; meghanada-run-task
;; meghanada-exec-main
;; meghanada-debug-main
;; meghanada-jump-declaration
;; meghanada-jump-symbol
;; meghanada-back-jump
;; meghanada-code-beautify
;; meghanada-reference
;; meghanada-typeinfo
;; meghanada-search-everywhere
;; meghanada-search-everywhere-ex
;; meghanada-show-project
