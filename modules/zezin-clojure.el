(use-package cider
  :init
  (setq cider-repl-pop-to-buffer-on-connect nil)
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  ;; (require 'eval-sexp-fun)
  )

(use-package clojure-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))
    (add-to-list 'magic-mode-alist '("#!.*boot\\s-*$" . clojure-mode))))

(use-package clojure-snippets)

(use-package clj-refactor
  :init
  (add-hook 'clojure-mode-hook 'clj-refactor-mode))

(use-package clojure-cheatsheet
  :after clojure-mode)

(use-package flycheck-clojure
  :after flycheck
  :config
  (flycheck-clojure-setup))


;; clj-refactor keybindings
;; clojure-align keybinding
;; clojure-snippets
;; cider-refresh
;; clojure-cheatsheet
;; slamhound
;; cider-eval-file
(zezin-add-keybinding :language
		      '(("f" cider-find-var)
			("j" cider-doc))
		      :map 'clojure-mode-map)

(provide 'zezin-clojure)
;;; zezin-clojure ends here
