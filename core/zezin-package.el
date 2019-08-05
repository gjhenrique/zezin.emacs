(require 'package)

(setq package--init-file-ensured t)
(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-user-dir (expand-file-name "elpa" zezin-dir))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package quelpa
  :init
  (setq quelpa-update-melpa-p nil)
  :config
  (progn
    (quelpa
     '(quelpa-use-package
       :fetcher git
       :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
    (require 'quelpa-use-package)))

(provide 'zezin-package)
;;; zezin-package.el ends here
