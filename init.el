;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

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
(require 'zezin-purpose)

(require 'zezin-keybindings)

(require 'zezin-git)
(require 'zezin-org)
(require 'zezin-emacs-lisp)
(require 'zezin-ruby)
(require 'zezin-javascript)
(require 'zezin-web)
(require 'zezin-docker)

;; Loading themes and fonts
(defun zezin-select-fonts-theme ()
  (load-theme 'base16-oceanicnext t)
  (if (x-list-fonts "Source Code Pro")
      (set-frame-font "Source Code Pro 12")
    (message "Source Code Pro is not installed")))

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(select-frame frame)
		(zezin-select-fonts-theme)))
  (zezin-select-fonts-theme))
