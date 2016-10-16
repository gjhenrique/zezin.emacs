(setq load-prefer-newer t)

(defvar zezin-dir (file-name-directory load-file-name))
(defvar zezin-cache-dir (expand-file-name ".cache/" zezin-dir))
(defvar zezin-core-dir (expand-file-name "core" zezin-dir))
(defvar zezin-modules-dir (expand-file-name "modules" zezin-dir))

(add-to-list 'load-path zezin-core-dir)
(add-to-list 'load-path zezin-modules-dir)

(require 'zezin-package)
(require 'zezin-global-conf)
(require 'zezin-evil)
(require 'zezin-editor)
(require 'zezin-helm)
(require 'zezin-editor)
(require 'zezin-window)

(find-file "/home/guilherme/Projects/zezin/init.el")
(set-frame-font "Source Code Pro 12")
(load-theme 'base16-oceanicnext t)

(require 'zezin-emacs-lisp)

; interesting packages

; evil
; evil-anzu
; evil-nerd-commenter
; evil-matchit

; ace-window - better window manipulation
; avy - hints for jump in certain point
; beacon - highlight
; bm
; dash? - functional library
; dicover-my-major?
; diff-hl?
; expand-region
; helm-swoop
; golden-ratio
; perspective
; prodigy
; relative-line-numbers
; recentf
; which-key
; remember-mode?
; yasnippet
