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
(defvar zezin-backup-dir (expand-file-name ".backups/" zezin-dir))
(defvar zezin-vendor-dir (expand-file-name "vendor/" zezin-dir))

(defun zezin-create-inexistent-folder (folder-name)
  (unless (file-exists-p folder-name)
    (make-directory folder-name)))

(zezin-create-inexistent-folder zezin-cache-dir)
(zezin-create-inexistent-folder zezin-backup-dir)

(add-to-list 'load-path zezin-core-dir)
(add-to-list 'load-path zezin-modules-dir)
(add-to-list 'load-path zezin-vendor-dir)

(require 'zezin-package)
(require 'zezin-global-conf)
(require 'zezin-evil)
(require 'zezin-editor)
(require 'zezin-window)
(require 'zezin-ivy)
(require 'zezin-purpose)

(require 'zezin-keybindings)

(require 'zezin-git)
(require 'zezin-org)
(require 'zezin-emacs-lisp)
(require 'zezin-ruby)
(require 'zezin-web)
(require 'zezin-javascript)
(require 'zezin-elixir)
(require 'zezin-go)
(require 'zezin-misc)
