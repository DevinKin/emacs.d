(defun +yas-first (text)
  (car (split-string text " ")))

(defun +yas-sql-mode-fields-to-values (text)
  (string-join
   (mapcar (lambda (s)
             (replace-regexp-in-string
              "\"" ":"
              (replace-regexp-in-string
               "\"$" ""
               (string-trim s))))
           (split-string text ","))
   ", "))

(defun +yas-next ()
  (interactive)
  (if (company--active-p)
      (progn
	(message "company")
	(company-complete-selection)
	)
    (progn
      (message "yasnippet")
      (yas-next-field-or-maybe-expand))))

(defun +yas-abort ()
  "Abort completion or snippet."
  (interactive)
  (if company-candidates
      (company-abort)
    (yas-abort-snippet)))

(defun +yas-start ()
  (setq-local cursor-type '(hbar . 4)))

(defun +yas-init ()
  (yas-reload-all)
  (add-hook 'yas/before-expand-snippet-hook '+yas-start))

(advice-add '+yas-init :around #'+make-silent)

(defun +yas-load-local-snippets ()
  (interactive)
  (when (projectile-project-root)
    (let ((local-yas-dir (concat (projectile-project-root) ".yas")))
      (when (file-directory-p local-yas-dir)
        (yas-load-directory local-yas-dir)))))


(use-package yasnippet
  :bind
  (:map
   yas-keymap
   ("<escape>" . '+yas-abort)
   ("C-u" . '+yas-abort)
   ("RET" . '+yas-next)
   ("<return>" . '+yas-next)
   ("M-<return>" . 'newline-and-indent)
   ("S-<return>" . 'yas-prev-field))
  :config
  (+yas-init)
  (unbind-key "<return>" yas-keymap)
  (unbind-key "S-<return>" yas-keymap)
  (unbind-key "<tab>" yas-keymap)
  (unbind-key "TAB" yas-keymap)
  (unbind-key "S-TAB" yas-keymap)
  (advice-add 'yas--auto-fill-wrapper :override #'ignore)
  :init
  (add-hook 'snippet-mode-hook #'smartparens-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'org-mode-hook #'yas-minor-mode)
  (add-hook 'yas-minor-mode-hook #'+yas-load-local-snippets)
  )

(make-variable-buffer-local 'yas-snippet-dirs)

(provide 'init-snippet)
