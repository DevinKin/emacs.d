;; See also init-clojure-cider.el

(progn (maybe-require-package 'clojure-mode)
       (maybe-require-package 'clj-refactor)
       (maybe-require-package 'cider))

;  (after-load 'clojure-mode
;    (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
;    (add-hook 'clojure-mode-hook 'subword-mode)))
  
(defun user/clojure-comment ()
  (interactive)
  (cond
   ((not current-prefix-arg)
    (save-mark-and-excursion
      (if (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
          (while (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
            (delete-char 2))
        (progn
          (unless (or (equal (char-after) 40)
                      (equal (char-after) 91)
                      (equal (char-after) 123))
            (backward-up-list))
          (if (string-suffix-p "#_" (buffer-substring-no-properties (line-beginning-position) (point)))
              (while (string-suffix-p "#_" (buffer-substring-no-properties (line-beginning-position) (point)))
                (delete-char -2))
            (insert "#_"))))))

   ((numberp current-prefix-arg)
    (let* ((curr-sym (symbol-at-point))
           (curr-sym-name (symbol-name curr-sym))
           (line (buffer-substring-no-properties (point) (line-end-position)))
           (i 0))
      (save-mark-and-excursion
        (when curr-sym
          (unless (string-prefix-p curr-sym-name line)
            (backward-sexp))
          (while (< i current-prefix-arg)
            (insert "#_")
            (setq i (1+ i)))))))

   ((equal '(4) current-prefix-arg)
    (save-mark-and-excursion
      (unless (and (equal (char-after) 40)
                   (equal (point) (line-beginning-position)))
        (beginning-of-defun)
        (if (equal "#_" (buffer-substring-no-properties (point) (+ 2 (point))))
            (delete-char 2)
          (insert "#_")))))))

(use-package clojure-mode
  :bind
  (:map clojure-mode-map
	("C-c C-i" . 'cider-inspect-last-result)
	("C-#" . 'user/clojure-comment))
  :init
  (setq clojure-toplevel-inside-comment-form t)
  :config
  (modify-syntax-entry ?: "w" clojure-mode-syntax-table)
  (setq clojure-indent-style 'always-indent)
  (add-to-list 'clojure-font-lock-keywords
               `(,(concat "\\(:\\{1,2\\}\\)\\("
                          clojure--sym-regexp
                          "?\\)\\(/\\)\\("
                          clojure--sym-regexp
                          "\\)")
                 (0 'clojure-keyword-face))))

(use-package clj-refactor
  :pin "melpa-stable"
  :hook (clojure-mode . clj-refactor-mode)
  :bind
  (:map
   clojure-mode-map
   ("/" . 'cljr-slash))
  :init
  (setq cljr-warn-on-eval t)
  (setq cljr-suppress-middleware-warnings t)
  :config
  (unbind-key "/" clj-refactor-map)
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(use-package cider
  :pin "melpa-stable"
  :commands (cider-jack-in cider-jack-in-cljs cider-jack-in-clj&cljs)
  :bind
  (:map
   cider-mode-map
   ("C-!" . 'cider-read-and-eval)
   ("C-." . 'cider-find-var)
   ("C-c C-n" . 'cider-ns-map)


   :map
   cider-repl-mode-map
   ("C-," . 'cider-repl-handle-shortcut)
   ("<backspace>" . 'paredit-backward-delete))

  :config
  (unbind-key "M-." cider-mode-map)

  :init
  (add-hook 'cider--debug-mode-hook 'user/insert-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-mode)
  (setq cider-font-lock-dynamically t
	cider-font-lock-reader-conditionals t
	cider-prompt-for-symbol nil
	cider-enhanced-cljs-completion-p nil
	)
  (setq-default cider-default-cljs-repl 'shadow)
  )

(provide 'init-clojure)
;;; init-clojure.el ends here
