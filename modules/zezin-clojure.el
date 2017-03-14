(use-package cider
  :init
  (setq )
  cider-repl-use-clojure-font-lock t

  )



(use-package clojure-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))
    ;; This regexp matches shebang expressions like `#!/usr/bin/env boot'
    (add-to-list 'magic-mode-alist '("#!.*boot\\s-*$" . clojure-mode))))

;; TODO: clojure-align keybinding
;; clojure-snippets

(provide 'zezin-clojure)
;;; zezin-clojure ends here
