(setq load-prefer-newer t)

(defvar zezin-dir (file-name-directory load-file-name))
(defvar zezin-cache-dir (expand-file-name ".cache/" zezin-dir))
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

(require 'zezin-keybindings)

(require 'zezin-git)
(require 'zezin-org)
(require 'zezin-emacs-lisp)
(require 'zezin-ruby)

(find-file "/home/guilherme/Projects/zezin/init.el")

(if (x-list-fonts "Source Code Pro")
    (set-frame-font "Source Code Pro 12")
  (message "Source Code Pro is not installed"))

(load-theme 'base16-oceanicnext t)
(require 'zezin-javascript)
