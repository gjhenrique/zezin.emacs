(setq load-prefer-newer t)

(defvar zezin-dir (file-name-directory load-file-name))
(defvar zezin-cache-dir (expand-file-name ".cache/" zezin-dir) )
(unless (file-exists-p zezin-cache-dir)
    (make-directory zezin-cache-dir))
(defvar zezin-core-dir (expand-file-name "core" zezin-dir))
(defvar zezin-modules-dir (expand-file-name "modules" zezin-dir))
(setq package-user-dir (expand-file-name "elpa" zezin-dir))

(add-to-list 'load-path zezin-core-dir)
(add-to-list 'load-path zezin-modules-dir)

(require 'zezin-package)
(require 'zezin-global-conf)
(require 'zezin-evil)
(require 'zezin-editor)
(require 'zezin-helm)
(require 'zezin-editor)
(require 'zezin-window)
(require 'zezin-git)

(require 'zezin-emacs-lisp)

(find-file "/home/guilherme/Projects/zezin/init.el")
(set-frame-font "Source Code Pro 12")
(load-theme 'base16-oceanicnext t)

; interesting packages

; evil
; evil-anzu
; evil-nerd-commenter
; evil-matchit
; evil-escape

;; ace-window - better window manipulation
;; agressive-indent-mode
;; avy - hints for jump in certain point
;; beacon - highlight
;; bm
;; dash? - functional library
;; dicover-my-major?
;; diff-hl?
;; expand-region
;; helm-swoop
;; golden-ratio
;; google-translate
;; perspective
;; prodigy
;; relative-line-numbers
;; recentf
;; skewer
;; which-key
;; remember-mode?
;; yasnippet

;; flycheck-tooltip
