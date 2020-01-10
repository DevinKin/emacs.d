(setq c-basic-offset 4)
(use-package irony
  :ensure t
  :init (progn
	  (defun devinkin/irony-mode-hook ()
	    (define-key irony-mode-map [remap completion-at-point] 'counsel-irony)
	    (define-key irony-mode-map [remap complete-symbol] 'counsel-irony))

	  (add-hook 'c++-mode-hook 'irony-mode)
	  (add-hook 'c-mode-hook 'irony-mode)
	  (add-hook 'irony-mode-hook 'devinkin/irony-mode-hook)
	  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
	  
	  (when *win64*
	    (setq w32-pipe-read-delay 0))
	  ))

(use-package clang-format
  :ensure t
  :commands (clang-format-region clang-format-buffer)
  :config (progn
	    (setq clang-format-style "llvm")))

(use-package cmake-id
  :ensure t
  :init (progn
	  (add-hook 'c++-mode-hook (lambda () (cmake-ide-setup)))
	  (add-hook 'c-mode-hook (lambda () (cmake-ide-setup)))))

(use-package cmake-mode
  :ensure t
  :mode (
	   ("CMakeLists\\.txt\\'" . cmake-mode)
	   ("\\.cmake\\'" . cmake-mode)
	  ))

(use-package company-rtags
  :ensure t)

(use-package rtags
  :ensure t
  :init (progn
	  (setq rtags-completions-enabled t)
	  (eval-after-load 'company
	    '(add-to-list
	      'company-backends 'company-rtags))
	  ;; (setq rtags-autostart-diagnostics t)
	  (rtags-enable-standard-keybindings)
	  )
  )

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; flycheck
(use-package flycheck
  :ensure t
  :demand t
  :config(progn
	   (setq flycheck-mode-line-prefix "FC")
	   (global-flycheck-mode t)))
(use-package flycheck-irony
  :ensure t
  :defer t
  :init (progn
	  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
	  ))
(add-hook 'c++-mode-hook (lambda ()
			   (setq flycheck-clang-language-standard "c++11")
			   (setq irony-additional-clang-options '("-std=c++11"))
			   ))

;;; C/C++ headers completion
(use-package company-c-headers
  :ensure t
  :defer t
  :init (progn (add-hook 'c-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-c-headers))
			 )
	       (add-hook 'c++-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-c-headers)))
	       )
  )
;;; backends for irony
(use-package company-irony
  :ensure t
  :defer t
  :init (progn (add-hook 'c-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-irony)))
	       (add-hook 'c++-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-irony)))
	       ))

;;; backends for irony-c-header
(use-package company-irony-c-headers
  :ensure t
  :defer t
  :init (progn (add-hook 'c-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-irony-c-headers)))
	       (add-hook 'c++-mode-hook
			 (lambda () (add-to-list 'company-backends 'company-irony-c-headers)))
	       ))
(use-package cc-mode
  :mode
  (("\\.c\\'" . c-mode)
   ("\\.h\\'" . c++-mode)
   ("\\.hpp\\'" . c++-mode)
   ("\\.cpp\\'" . c++-mode))
  :config (progn
	    (eval-after-load "cc-mode"
	      '(define-key c-mode-base-map ";" nil)))
  )

(provide 'init-c-c++)
