(use-package magit
  :bind (:git ("f" . magit-status)))

(use-package evil-magit
  :after magit) 

(provide 'zezin-git)
;;; zezin-git.el ends here
