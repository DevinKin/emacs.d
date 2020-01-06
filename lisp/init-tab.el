(defun user/insert-tab ()
  (interactive)
  (cond
   ((region-active-p)
    (call-interactively 'indent-region))
   ((string-match-p "^[ \t]*$"
                    (buffer-substring-no-properties
                     (line-beginning-position)
                     (point)))
    (call-interactively #'indent-for-tab-command))
   ((nth 3 (syntax-ppss))
    (paredit-forward-up))
   (t
    (company-complete-common-or-cycle))))

(bind-key "<tab>" 'user/insert-tab prog-mode-map)

(provide 'init-tab)
