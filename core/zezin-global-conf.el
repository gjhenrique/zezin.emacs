(setq gc-cons-threshold 50000000)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq load-prefer-newer t)
(setq make-backup-files nil)
(setq initial-scratch-message nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(global-linum-mode)
(fset 'yes-or-no-p 'y-or-n-p)

; TODO: Unassign M-<key> for all letters

(global-set-key (kbd "M-e") nil)
(global-set-key (kbd "M-w") nil)
(global-set-key (kbd "M-f") nil)
(global-set-key (kbd "M-s") nil)
(global-set-key (kbd "M-j") nil)

(use-package dash)

(defconst zezin-prefix-keys
  #s(hash-table data
		(:buffer "j"
		 :window "f"
		 :editor "g"
		 :projectile "h"
		 :search "d"
		 :git "s"
		 :language "k")))

(maphash
 (lambda (key value)
   (global-set-key (kbd (concat "M-" value)) nil))
 zezin-prefix-keys) 

(defun zezin-prefix-select-key (prefix key)
  (kbd
   (concat "M-"(gethash prefix zezin-prefix-keys) " M-" key)))

(defun use-package-handle-keybinding (prefix list)
  (let* ((is-keyword (keywordp (car list)))
	 (real-prefix (if is-keyword (car list) prefix))
	 (keybinding (if is-keyword (car (cdr list)) (car list))))
    (cond ((equal :global (car list))
	   (cdr list))
	  ((or is-keyword (not (equal :global prefix)))
	   (let* ((list-rest (if is-keyword (cdr (cdr list)) (cdr list)))
		  (real-keybinding
		   (concat "M-" (gethash real-prefix zezin-prefix-keys) " M-" keybinding)))
	  (append `(,real-keybinding) list-rest)))
	  (t list))))

(defun use-package-zezin-keybinding (args)
  (let ((current-prefix :global)
        (keybinds-list (car (cdr (member :bind args)))))
    (-reduce-from
     (lambda (memo item)
       (cond ((and (keywordp item) (not (equal item :map)))
              (progn
                (setq current-prefix item)
                memo))
             ((listp item)
              (let ((keys (use-package-handle-keybinding current-prefix item)))
                (append memo `(,keys))))
             (t (append memo `(,item)))))
     []
     keybinds-list)))

(defun zezin-use-package-advice (args)
  (if (and args (member :bind args))
    (let* ((syntax-args (use-package-zezin-keybinding (cdr args)))
	   (position (cl-position :bind args)))
      (setf (nth (+ position 1) args) syntax-args)
      (message "%s" args)
      args)
    args))

(advice-add 'use-package :filter-args #'zezin-use-package-advice)

(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize))) 

(use-package auto-package-update)
(use-package pcre2el)

(provide 'zezin-global-conf)
;;; zezin-global-conf.el ends here
