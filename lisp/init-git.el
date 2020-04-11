;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

;; TODO: link commits from vc-log to magit-show-commit
;; TODO: smerge-mode

(progn
  (maybe-require-package 'magit)
  (maybe-require-package 'diff-hl)
  (maybe-require-package 'gitignore-mode)
  )

(use-package magit
  :commands (magit-status)
  :bind
  ("C-M-G" . 'magit-status)
  )

(use-package diff-hl
  :bind
  ("C-S-G" . 'diff-hl-mode))

(use-package gitignore-mode
  :hook (gitignore-mode . yas-minor-mode))


(use-package evil-magit
  :ensure t
  :after evil magit
  :init
  (setq evil-magit-state 'normal)
  (setq evil-magit-use-y-for-yank t)
  :config
  (evil-magit-revert)
  )

(provide 'init-git)
;;; init-git.el ends here
