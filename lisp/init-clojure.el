;; See also init-clojure-cider.el

;(when (maybe-require-package 'clojure-mode)
;  (require-package 'cljsbuild-mode)
;  (require-package 'elein)

;  (after-load 'clojure-mode
;    (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
;    (add-hook 'clojure-mode-hook 'subword-mode)))

(defun user/clojure-comment ()
  (interactive)
  (message "hello")
  (cond
   ((not current-prefix-arg)
    (if (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
	(while (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
	  (delete-char 2))
      )
    
   

   ((numberp current-prefix-arg)
    (message "%s" current-prefix-arg))
   

   ((equal '(4) current-prefix-arg)
    (save-mark-and-excursion
      (unless (and (equal (char-after) 40)
		 (equal (point) (line-beginning-position)))
      (beginning-of-defun)
      (if (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
	  (delete-char 2)
	(insert "#_")))))
   )
  )

(bind-key "C-#" 'user/clojure-comment clojure-mode-map)

(use-package clojure-mode
  :bind
  (:map clojure-mode-map
	("C-c C-i" . 'cider-inspect-last-result)
	("C-#" . 'user/clojure-hash-comment)))

(current-prefix-arg)

(provide 'init-clojure)
;;; init-clojure.el ends here
