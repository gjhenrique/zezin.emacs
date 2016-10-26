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
(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package auto-package-update)
(use-package pcre2el)

(defvar zezin-prefix-key-window "g")
(defvar zezin-prefix-key-files "f")
(defvar zezin-prefix-key-projectile "j")

(defun use-package-eval-keybinding (prefix)
 (eval
  (intern
   (concat "zezin-prefix-key-"
           (substring (symbol-name prefix) 1)))))

(defun use-package-handle-keybinding (prefix list)
  (let* ((is-keyword (keywordp (car list)))
	 (real-prefix (if is-keyword (car list) prefix))
	 (keybinding (if is-keyword (car (cdr list)) (car list))))
    (cond ((equal :global (car list))
	   (cdr list))
	  ((or is-keyword (not (equal :global prefix)))
	   (let* ((list-rest (if is-keyword (cdr (cdr list)) (cdr list)))
		  (real-keybinding
		   (concat "M-" (use-package-eval-keybinding real-prefix) " M-" keybinding)))
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
  (when (and args (member :bind args))
    (let* ((syntax-args (use-package-zezin-keybinding (cdr args)))
	   (position (cl-position :bind args)))
      (setf (nth (+ position 1) args) syntax-args)
      (message "%s" args)
      args)))


;; M-f - files and buffers
;; M-j - windows and frames
;; M-d - editor related stuff
;; M-k - projectile
;; M-g - search - projectile search, google search, google-translate
;; M-h - language stuff
;; M-l - git

(provide 'zezin-global-conf)
;;; zezin-global-conf.el ends here
