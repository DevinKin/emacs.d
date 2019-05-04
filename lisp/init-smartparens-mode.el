(require 'smartparens)
;; 补全括号
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'after-init-hook 'show-paren-mode)

;; emacs-mode下不补全'
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))


(provide 'init-smartparens-mode)


