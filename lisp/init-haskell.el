(require-package 'haskell-mode)

(when (maybe-require-package 'intero)
  (after-load 'haskell-mode
    (intero-global-mode)
    (add-hook 'haskell-mode-hook 'subword-mode)
    (add-hook 'haskell-mode-hook 'eldoc-mode))
  (after-load 'haskell-cabal
    (add-hook 'haskell-cabal-mode 'subword-mode)
    (define-key haskell-cabal-mode-map (kbd "C-c C-l") 'intero-restart))
  (after-load 'intero
    ;; Don't clobber sanityinc/counsel-search-project binding
    (define-key intero-mode-map (kbd "M-?") nil)
    (after-load 'flycheck
      (flycheck-add-next-checker 'intero
                                 '(warning . haskell-hlint)))))

(add-auto-mode 'haskell-mode "\\.ghci\\'")

(after-load 'haskell-mode
  (define-key haskell-mode-map (kbd "C-c h") 'hoogle)
  (define-key haskell-mode-map (kbd "C-o") 'open-line))

(after-load 'page-break-lines
  (push 'haskell-mode page-break-lines-modes))

(define-minor-mode stack-exec-path-mode
  "If this is a stack project, set `exec-path' to the path \"stack exec\" would use."
  nil
  :lighter ""
  :global nil
  (if stack-exec-path-mode
      (when (and (executable-find "stack")
                 (locate-dominating-file default-directory "stack.yaml"))
        (setq-local
         exec-path
         (seq-uniq
          (append (list (concat (string-trim-right (shell-command-to-string "stack path --local-install-root")) "/bin"))
                  (parse-colon-path
                   (replace-regexp-in-string "[\r\n]+\\'" ""
                                             (shell-command-to-string "stack path --bin-path"))))
          'string-equal))
                                        ;(add-to-list (make-local-variable 'process-environment) (format "PATH=%s" (string-join exec-path path-separator)))
        )
    (kill-local-variable 'exec-path)))

(add-hook 'haskell-mode-hook 'stack-exec-path-mode)
