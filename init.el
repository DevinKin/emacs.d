
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; 初始化包
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-packages)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load (expand-file-name "custom.el" user-emacs-directory))

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

