(defun +eshell-ls-lha ()
  (interactive)
  (eshell-kill-input)
  (insert "ls -lh")
  (eshell-send-input))

(defun +eshell-ls-lh ()
  (interactive)
  (eshell-kill-input)
  (insert "ls -lh")
  (eshell-send-input))

(defun eshell/h (&rest args)
  (apply #'eshell/ls "-lh" args))

(defun eshell/d (&rest args)
  (if args
      (apply #'dired args)
    (dired ".")))

(defun eshell/e (&rest args)
  (apply #'find-file args))

(defun eshell/f (&rest args)
  (apply #'find-file-other-window args))

(defun eshell/q (&rest args)
  (eshell/exit))

(provide 'init-eshell)

