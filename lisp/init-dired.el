;; 总是递归删除目录
(setq dired-recursive-deletes 'always)
;; 总是递归拷贝目录
(setq dired-recursive-copies 'always)

(require 'dired-x)

(put 'dired-find-alternate-file 'disabled nil)


;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; 分屏拷贝
(setq dired-dwim-target 1)


(use-package vscode-icon
  :ensure t
  :commands (vscode-icon-for-file))

;; dired-sidebar
(use-package dired-sidebar
    :ensure t
    :commands (dired-sidebar-toggle-sidebar)

    :bind
    (("C-x C-n" . dired-sidebar-toggle-sidebar)

     :map
     dired-sidebar-mode-map
     ("q" . 'kill-buffer-and-window))

    :init
    (add-hook 'dired-sidebar-mode-hook 'hl-line-mode)
    (setq dired-sidebar-subtree-line-prefix " ")
    (setq dired-sidebar-theme 'vscode)
    ;(setq dired-sidebar-theme 'ascii)
    (setq dired-sidebar-use-custom-font t)
    )

(provide 'init-dired)
