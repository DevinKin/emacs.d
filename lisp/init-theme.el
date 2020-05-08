;(maybe-require-package 'solarized-theme)

;(load-theme 'solarized-dark t)

;(maybe-require-package 'atom-one-dark-theme)
;(load-theme 'atom-one-dark t)
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t)
  )

(provide 'init-theme)
