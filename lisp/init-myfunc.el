;; F2打开配置文件
(defun open-init-file()
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))
(global-set-key (kbd "<f2>") 'open-init-file)

(defun open-custom-file()
  (interactive)
  (find-file (expand-file-name "custom.el" user-emacs-directory)))
(global-set-key (kbd "<f3>") 'open-custom-file)


;; 打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(provide 'init-myfunc)
