;; 显示行号
(maybe-require-package 'linum-relative)
(require 'linum-relative)

(setq linum-relative-backend 'display-line-numbers-mode)
(global-display-line-numbers-mode 1)
(linum-relative-on)


(provide 'init-linum-mode)
