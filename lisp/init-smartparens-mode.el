(require 'smartparens)
;; 补全括号
(add-hook 'prog-mode-hook 'smartparens-mode)
;; lisp交互模式启用
(add-hook 'lisp-interaction-mode-hook 'smartparens-mode)
(add-hook 'slime-repl-mode-hook 'smartparens-mode)
(add-hook 'after-init-hook 'show-paren-mode)

;; fix hungry-delete & smartparents conflict
(defadvice hungry-delete-backward (before sp-delete-pair-advice activate) (save-match-data (sp-delete-pair (ad-get-arg 0))))

;; emacs-mode下不补全'
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'lisp-mode "'" nil :actions nil)
(sp-local-pair 'slime-repl-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))


(provide 'init-smartparens-mode)


