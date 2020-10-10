;; F2打开配置文件
(defun open-init-file()
  "Open init file with key <f2>"
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))
(global-set-key (kbd "<f2>") 'open-init-file)

;; F3打开自定义文件
(defun open-custom-file()
  "Open custom file with key <f3>"
  (interactive)
  (find-file (expand-file-name "custom.el" user-emacs-directory)))
(global-set-key (kbd "<f3>") 'open-custom-file)

;; 缩进buffer
(defun indent-buffer()
  "Indent current-buffer"
  (interactive)
  (indent-region (point-min) (point-max)))

;; 缩进buffer或者region
(defun indent-region-or-buffer()
  "Indent current buffer or region"
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

;; 打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(provide 'init-myfunc)
