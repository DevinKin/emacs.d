(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
;; gofmt
(add-hook 'before-save-hook 'gofmt-before-save)

;; company-go
(require 'company)
(require 'company-go)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(add-hook 'go-mode-hook (lambda ()
			  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))


;; goflymake
(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake/")
(require 'go-flycheck)
(require 'go-flymake)
(add-hook 'flymake-mode-hook
      (lambda()
        (local-set-key (kbd "C-c C-e n") 'flymake-goto-next-error)))
(add-hook 'flymake-mode-hook
      (lambda()
        (local-set-key (kbd "C-c C-e p") 'flymake-goto-prev-error)))
(add-hook 'flymake-mode-hook
      (lambda()
        (local-set-key (kbd "C-c C-e m") 'flymake-popup-current-error-menu)))

;; go tab width
(add-hook 'go-mode-hook
	  (lambda ()
	    (setq tab-width 4)))
(add-hook 'go-mode-hook #'aggressive-indent-mode)

(provide 'init-go)
