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

(provide 'init-dired)
