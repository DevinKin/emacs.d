;; 插件安装
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar devinkin/packages '(
			    iedit
			    expand-region
			    popwin
			    ;; --- Auto-completion ---
			    company
			    ;; --- Better Editor ---
			    hungry-delete
			    swiper
			    counsel
			    smartparens
			    ;; --- Major Mode ---
			    js2-mode
			    ;; --- Minor Mode ---
			    nodejs-repl
			    exec-path-from-shell
			    ;; --- Themes ---
			    darkburn-theme

			    ;; org-mode
			    use-package
			    org-bullets
			    org-pomodoro
			    org-alert

			    
			    ;; org-publish
			    htmlize
			    dracula-theme

			    helm-ag
			    ) "Default packages")

(setq package-selected-packages devinkin/packages)

(defun devinkin/packages-installed-p ()
  (loop for pkg in devinkin/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (devinkin/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg devinkin/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))(when ())

(provide 'init-packages)
