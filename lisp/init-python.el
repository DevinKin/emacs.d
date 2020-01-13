(setq python-indent-offset 4)
(setq python-indent-guess-indent-offset nil)

(use-package anaconda-mode
  :ensure t
  :defer t
  :bind
  (:map anaconda-mode-map
	("C-c g g" . 'anaconda-mode-find-definitions))
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  )

(use-package company-jedi
  :defer t
  :ensure t
  :init
  (add-to-list 'company-backends 'company-jedi)
  )

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (add-to-list 'company-backends 'elpy-company-backend)
  )


(use-package python
  :ensure t
  :bind
  (:map python-mode-map
	("C-c /" . 'devinkin/py-func-comment)
   ))

(defun devinkin/py-func-comment()
  "Python function comment."
  (interactive)
  (insert "\"\"\"")
  (newline-and-indent)
  (insert "comment")
  (save-mark-and-excursion
    (newline-and-indent)
    (insert "\"\"\""))
  )


(provide 'init-python)
