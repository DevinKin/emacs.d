;(maybe-require-package 'solarized-theme)

;(load-theme 'solarized-dark t)

;(maybe-require-package 'atom-one-dark-theme)
;(load-theme 'atom-one-dark t)
;(use-package zenburn-theme
;  :ensure t
;  :config
;  (load-theme 'zenburn t)
;  )
;(use-package material-theme
;  :ensure t
;  :config
;  (load-theme 'material t))

(use-package tron-legacy-theme
  :ensure t
  :config
  (setq tron-legacy-theme-vivid-cursor t)
  (setq tron-legacy-theme-softer-bg t)
  (load-theme 'tron-legacy t))
(provide 'init-theme)
