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
			    youdao-dictionary
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

			    ;; --- programming language ---
			    slime

			    magit
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


;; See https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el
;;; On-demand installation of packages

(require 'cl-lib)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (versions (mapcar #'package-desc-version known)))
        (if (cl-find-if (lambda (v) (version-list-<= min-version v)) versions)
            (package-install package)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t))))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

(provide 'init-packages)
