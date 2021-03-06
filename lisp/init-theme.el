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

(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-frame-parameter (selected-frame) 'alpha 90)

(provide 'init-theme)
