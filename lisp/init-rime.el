(maybe-require-package 'rime)
(use-package rime
  :custom
  (default-input-method "rime")
  :bind
  (:map rime-mode-map
        ("C-`" . 'rime-send-keybinding))
  )

;; defaults
(setq rime-translate-keybindings
  '("C-f" "C-b" "C-n" "C-p" "C-g"))


(provide 'init-rime)

