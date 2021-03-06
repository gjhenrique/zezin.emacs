(defun zezin-alternate-buffer-another-window ()
  (interactive)
  (switch-to-buffer-other-window (car (evil-alternate-buffer))))

(use-package ace-window
  :commands ace-window
  :init
  (setq aw-keys '(?f ?j ?d ?k ?g ?h ?s ?l ?a)))

(use-package golden-ratio
  :disabled
  :defer 20
  :init
  (setq golden-ratio-adjust-factor 1
        golden-ratio-wide-adjust-factor 1)
  :config
  (progn
    (golden-ratio-mode)
    (dolist (f '(ace-window
                 ace-delete-window
                 ace-select-window
                 ace-swap-window
                 ace-maximize-window
                 avy-pop-mark
                 buf-move-left
                 buf-move-right
                 buf-move-up
                 buf-move-down
                 evil-avy-goto-word-or-subword-1
                 evil-avy-goto-char
                 evil-avy-goto-line
                 evil-window-delete
                 evil-window-split
                 evil-window-vsplit
                 evil-window-left
                 evil-window-right
                 evil-window-up
                 evil-window-down
                 evil-window-bottom-right
                 evil-window-top-left
                 evil-window-mru
                 evil-window-next
                 evil-window-prev
                 evil-window-new
                 evil-window-vnew
                 evil-window-rotate-upwards
                 evil-window-rotate-downwards
                 evil-window-move-very-top
                 evil-window-move-far-left
                 evil-window-move-far-right
                 evil-window-move-very-bottom
                 quit-window
                 select-window-0
                 select-window-1
                 select-window-2
                 select-window-3
                 select-window-4
                 select-window-5
                 select-window-6
                 select-window-7
                 select-window-8
                 select-window-9
                 windmove-left
                 windmove-right
                 windmove-up
                 windmove-down))
      (add-to-list 'golden-ratio-extra-commands f))))

;; from https://gist.github.com/3402786
(defun zezin-toggle-maximize-buffer ()
  (interactive)
  (if (and (= 1 (length (window-list)))
	   (assoc ?_ register-alist))
      (jump-to-register ?_)
    (progn
      (window-configuration-to-register ?_)
      (delete-other-windows))))

(defun split-window-below-and-focus ()
  (interactive)
  (split-window-below)
  (windmove-down))

(defun split-window-right-and-focus ()
  (interactive)
  (split-window-right)
  (windmove-right))

(provide 'zezin-window)
;;; zezin-window.el ends here
