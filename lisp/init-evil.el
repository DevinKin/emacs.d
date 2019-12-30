(require-package 'evil)
(evil-mode 1)


(when (maybe-require-package 'evil-leader)
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "ff" 'find-file
    "fr" 'recentf-open-files
    "bb" 'switch-to-buffer
    "0"  'select-window-0
    "1"  'select-window-1
    "2"  'select-window-2
    "3"  'select-window-3
    "wr" 'split-window-right
    "wb" 'split-window-below
    ":"  'counsel-M-x
    "wM" 'delete-other-windows
    "ud" 'undo-tree-visualize
    "oa" 'org-agenda
    "mgs" 'magit-status
    "llh" 'slime-hyperspec-lookup
    "sa" 'mark-whole-buffer
    "fj" 'dired-jump
    "ps" 'helm-do-ag-project-root
    ))

(when (maybe-require-package 'evil-surround)
  (global-evil-surround-mode))


(when (maybe-require-package 'evil-nerd-commenter)
  (global-evil-leader-mode)
  (evil-leader/set-key
    "ci" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "cc" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    "."  'evilnc-copy-and-comment-operator
    "\\" 'evilnc-comment-operator ; if you prefer backslash key
    ))

(provide 'init-evil)
