(use-package clojure-mode
  :mode (
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.boot\\'" . clojure-mode)
         ("#!.*boot\\s-*$" . clojure-mode)
         ("\\.cljc\\'" . clojurec-mode)
         ("\\.\\(clj\\|dtm\\|edn\\)\\'" . clojure-mode)))

(use-package cider
  :after clojure-mode
  :init
  (progn
    (setq nrepl-use-ssh-fallback-for-remote-hosts t)
    (setq cider-repl-pop-to-buffer-on-connect nil))
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode))

(use-package clojure-snippets
  :after (yasnippet clojure-mode))

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))

(use-package flycheck-clojure
  :after (flycheck clojure-mode)
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
