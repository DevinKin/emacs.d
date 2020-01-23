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

(use-package cmake-ide
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

  :bind
  (:map c-mode-map
   ("C-c C-r" . devinkin/gcc-compile-and-run))
  )


(defvar devinkin-default-gcc-compile-command "gcc -std=c99 -Wall")


(defun devinkin/compile-with-command-and-run (command oth-source-file)
  "Compile c/c++ with COMMAND and run it"
  (let ((file-name (buffer-file-name))
	(output (file-name-base (buffer-file-name)))
	(source-file (mapconcat 'identity
				(mapcar #'(lambda (s)
					    (concat default-directory s))
					(split-string oth-source-file " "))
				" ")))
    (message output)
    (if (eq system-type 'windows-nt)
	(compile (format "%s %s %s -o %s.exe && .\\%s.exe && rm %s.exe" command file-name source-file output output output))
      (compile (format "%s %s %s -o %s && ./%s && rm %s" command file-name source-file output output output)))
    ))



(defun devinkin/gcc-compile-and-run (command oth-source-file)
  "Compile c with gcc and run it COMMAND."
  (interactive
   (list (read-string (format "Compile and run command [default: %s]:" devinkin-default-gcc-compile-command)
		      nil nil devinkin-default-gcc-compile-command)
	 (read-string (format "Other Source file [default: %s]:" "main.c")
		      nil nil " main.c ")))
  (devinkin/compile-with-command-and-run command oth-source-file))


(provide 'init-c-c++)
