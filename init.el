;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

(require 'init-packages)
(require 'init-youdao)
(require 'init-utils)
(require 'init-org)
(require 'init-company)
(require 'init-linum-mode)
(require 'init-smartparens-mode)
(require 'init-org-publish)
(require 'init-myfunc)
(require 'init-ivy)
(require 'init-dired)
(require 'init-common-lisp)
(require 'init-haskell)



(provide 'init)

