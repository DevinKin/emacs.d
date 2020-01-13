(use-package tagedit
  :ensure t
  :config
  (after-load 'sgml-mode
    (tagedit-add-paredit-like-keybindings)
    (define-key tagedit-mode-map (kbd "M-?") nil)
    (define-key tagedit-mode-map (kbd "M-s") nil)
    (add-hook 'sgml-mode-hook (lambda () (tagedit-mode 1))))
  (add-auto-mode 'html-mode "\\.\\(jsp\\|tmpl\\)\\'")
  )

(provide 'init-html)

