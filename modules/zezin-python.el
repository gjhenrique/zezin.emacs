(use-package anaconda-mode
  :config
  (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-anaconda
  :after (anaconda company)
  :config
  (push 'company-anaconda company-backends ))

(provide 'zezin-python)
;;; zezin-python.el ends here
