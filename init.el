(setq load-prefer-newer t)

(defvar zezin-dir (file-name-directory load-file-name))
(defvar zezin-cache-dir (expand-file-name ".cache/" zezin-dir) )
(defvar zezin-core-dir (expand-file-name "core" zezin-dir))
(defvar zezin-modules-dir (expand-file-name "modules" zezin-dir))

(unless (file-exists-p zezin-cache-dir)
  (make-directory zezin-cache-dir))

(add-to-list 'load-path zezin-core-dir)
(add-to-list 'load-path zezin-modules-dir)

(require 'zezin-package)
(require 'zezin-global-conf)
(require 'zezin-evil)
(require 'zezin-editor)
(require 'zezin-helm)
(require 'zezin-window)
(require 'zezin-git)

(require 'zezin-org)
(require 'zezin-emacs-lisp)

(require 'zezin-keybindings)

(find-file "/home/guilherme/Projects/zezin/init.el")
(set-frame-font "Source Code Pro 12")
(load-theme 'base16-oceanicnext t)

;; ace-window - better window manipulation
;; agressive-indent-mode
;; avy - hints for jump in certain point
;; beacon - highlight
;; bm
;; dash? - functional library
;; dicover-my-major?
;; diff-hl?
;; expand-region
;; evil-smartparens
;; flyspell
;; helm-swoop
;; golden-ratio
;; git-gutter
;; google-translate
;; origami
;; perspective
;; prodigy
;; relative-line-numbers
;; recentf
;; skewer
;; smooth-scrolling
;; which-key
;; remember-mode?
;; yasnippet

;; modeline
;; flycheck-tooltip
