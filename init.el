;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(setq load-prefer-newer t)

(defvar zezin-dir (file-name-directory (substitute-in-file-name "$HOME/Projects/mine/zezin.emacs/")))
(defvar zezin-cache-dir (expand-file-name ".cache/" zezin-dir))
(defvar zezin-core-dir (expand-file-name "core" zezin-dir))
(defvar zezin-modules-dir (expand-file-name "modules" zezin-dir))
(defvar zezin-backup-dir (expand-file-name ".backups/" zezin-dir))
(defvar zezin-vendor-dir (expand-file-name "vendor/" zezin-dir))
(defvar zezin-work-script (expand-file-name "Life/work.el" (substitute-in-file-name "$HOME")))

(setq zezin-is-work-computer nil)
(setq zezin-4k-display nil)

(when (file-exists-p zezin-work-script)
  (load zezin-work-script))

(defun zezin-create-inexistent-folder (folder-name)
  (unless (file-exists-p folder-name)
    (make-directory folder-name)))

(zezin-create-inexistent-folder zezin-cache-dir)
(zezin-create-inexistent-folder zezin-backup-dir)

(message zezin-core-dir)
(add-to-list 'load-path zezin-core-dir)
(add-to-list 'load-path zezin-modules-dir)
(add-to-list 'load-path zezin-vendor-dir)

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; https://github.com/hlissner/doom-emacs/wiki/FAQ#how-is-dooms-startup-so-fast
(defvar zezin--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(require 'zezin-package)
(require 'zezin-global-conf)
(require 'zezin-evil)
(require 'zezin-editor)
(require 'zezin-window)
(require 'zezin-ivy)
(require 'zezin-purpose)

(require 'zezin-keybindings)

(if (eq system-type 'darwin)
    (require 'zezin-mac))

(require 'zezin-git)
(require 'zezin-org)
(require 'zezin-blogging)
(require 'zezin-emacs-lisp)
(require 'zezin-ruby)
(require 'zezin-c)
(require 'zezin-web)
(require 'zezin-javascript)
(require 'zezin-elixir)
(require 'zezin-go)
(require 'zezin-rust)
(require 'zezin-clojure)
(require 'zezin-python)
(require 'zezin-ocaml)
(require 'zezin-misc)

(defun zezin-define-startup-values ()
  (setq gc-cons-threshold 16777216
        gc-cons-percentage 0.1
        file-name-handler-alist zezin--file-name-handler-alist))

(add-hook 'emacs-startup-hook #'zezin-define-startup-values)
