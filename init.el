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
(require 'init-packages)
(require 'init-utils)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))


(defconst *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt))
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (>= emacs-major-version 24))
(setq *emacs25* (>= emacs-major-version 25))
(setq *emacs26* (>= emacs-major-version 26))

;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; Emacs 25 does gc too frequently
(when *emacs25*
  ;; (setq garbage-collection-messages t) ; for debug
  (setq best-gc-cons-threshold (* 64 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect))

(require 'init-tab)
;(require 'init-doom-modeline)
(require 'init-theme)
(require 'init-youdao)
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
(require 'init-git)
(require 'init-evil)
(require 'init-markdown)
(require 'init-hlindent)
(require 'init-erlang)
(require 'init-php)
(require 'init-paredit)
(require 'init-lisp)
(require 'init-clojure)
(require 'init-clojure-cider)
(require 'init-python)
(require 'init-c-c++)
(require 'init-html)
(require 'init-rust)
(require 'init-rime)
(require 'init-global)
(require 'init-project)
(require 'init-snippet)
(require 'init-ox-hugo)
(require 'init-eshell)
;(require 'init-go)

;(provide 'init)

