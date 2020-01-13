;; package --- Summary
;;; Code:
;;; Commentary:

(defun devinkin/get-rust-src-path()
  "Get the rust src path by rustc."
  (let* ((command (concat "rustc --print sysroot"))
	 (rustc-sysroot-path (shell-command-to-string command))
	 (strip-path (replace-regexp-in-string "\n$" "" rustc-sysroot-path)))
    (if (eq system-type 'windows-nt)
	(concat strip-path "\\lib\\rustlib\\src\\rust\\src")
      (concat strip-path "/lib/rustlib/src/rust/src"))))

(devinkin/get-rust-src-path)

(defun devinkin/get-rust-ld-library-path()
  "Get rust link library path."
  (let* ((command (concat "rustc --print sysroot"))
	 (rustc-sysroot-path (shell-command-to-string command))
	 (strip-path (replace-regexp-in-string "\n$" "" rustc-sysroot-path)))
    (if (eq system-type 'windows-nt)
	(concat strip-path "\\lib\\")
      (concat strip-path "/lib/"))))

(devinkin/get-rust-ld-library-path)


(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :init
  (progn
    (setenv "RUST_SRC_PATH" (devinkin/get-rust-src-path))
    (setenv "LD_LIBRARY_PATH" (devinkin/get-rust-ld-library-path))
    ;;; https://github.com/rust-lang/rust-mode/issues/208
    (setq rust-match-angle-brackets nil)
    )
  :config (remove-hook 'rust-mode-hook 'adaptive-wrap-prefix-mode)
  )

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))

(use-package cargo
  :diminish cargo-minor-mode
  :ensure t
  :defer t
  :init (progn
	  (add-hook 'rust-mode-hook 'cargo-minor-mode)))

(use-package flycheck-rust
  :ensure t
  :defer t
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package racer
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'rust-mode-hook #'eldoc-mode)

    (add-hook 'rust-mode-hook #'company-mode)
    )
  :config
  (setq company-tooltip-align-annotations t)

  ;:bind
  ;(:map racer-mode-map
	;("<tab>" . #'company-indent-or-complete-common)
  ;)
  )

(provide 'init-rust)
