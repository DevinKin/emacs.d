(add-hook 'after-init-hook 'global-company-mode)

(use-package company
  :ensure t
  :bind
  (:map company-mode-map
   ("<tab>" . 'user/insert-tab)

   :map company-active-map
   ("}" . 'company-select-next)
   ("{" . 'company-select-previous)
   ("<escape>" . 'company-abort))

  :init
  (setq company-idle-delay nil
	company-dabbrev-downcase nil
	company-abort-manual-when-too-short t
	company-require-match nil
	company-global-modes '(not dired-mode dired-sidebar-mode)
	)
  )

(eval-after-load 'company
  '(progn
     ;; I don't like the downcase word in company-dabbrev!
     (setq company-dabbrev-downcase nil
           ;; make previous/next selection in the popup cycles
           company-selection-wrap-around t
           ;; Some languages use camel case naming convention,
           ;; so company should be case sensitive.
           company-dabbrev-ignore-case nil
           ;; press M-number to choose candidate
           company-show-numbers t
           company-idle-delay 0.2
           company-clang-insert-arguments nil
           company-require-match nil
           company-etags-ignore-case t
           ;; @see https://github.com/company-mode/company-mode/issues/146
           company-tooltip-align-annotations t)
     ))

(provide 'init-company)
