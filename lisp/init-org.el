;; org-mode
(use-package org
  :commands (org-mode)
  :ensure t
  :bind
  ("C-<tab>" . org-cycle)

  :no-require t
  :config
  ;; org export markdown gitpage
  (when (maybe-require-package 'ox-gfm)
    (require 'ox-gfm nil t))
  (setq org-src-fontify-natively t)

  ;; org Agenda
  (setq org-agenda-files '("~/org"))
  (global-set-key (kbd "C-c a") 'org-agenda)
  
  ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ;;	Org TODO keywords
  ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  (setq org-todo-keywords 
	'((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "REVIEW(r)" "|" "DONE(d)" "CANCELED(c)")))

  (setq org-todo-keyword-faces
	'(("TODO" . org-warning)
	  ("INPROGRESS" . "yellow")
	  ("WAITING" . "purple")
	  ("REVIEW" . "orange")
	  ("DONE" . "green")
	  ("CANCELED" .  "red")))
  ;; close todo with note
  (setq org-log-done 'note)
  (setq org-startup-truncated t)

  (setq org-log-into-drawer t)
  (setq org-agenda-custom-commands
	'(("b" "Blog idea" tags-todo "BLOG")
	  ("s" "Someday" todo "SOMEDAY")
	  ("S" "Started" todo "STARTED")
	  ("w" "Waiting" todo "WAITING")
	  ("d" . " 任务安排 ")
	  ("da" " 重要且紧急的任务 " tags-todo "+PRIORITY=\"A\"")
	  ("db" " 重要且不紧急的任务 " tags-todo "+PRIORITY=\"B\"")
	  ("dc" " 不重要且紧急的任务 " tags-todo "+PRIORITY=\"C\"")
	  ("p" . " 项目安排 ")
	  ("W" "Weekly Review" tags-todo "PROJECT")))

  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  )
;; org-mode标题设置大小，高亮，加粗。
;(set-face-attribute 'org-level-1 nil :height 2.0 :bold t)
;(set-face-attribute 'org-level-2 nil :height 1.8 :bold t)
;(set-face-attribute 'org-level-3 nil :height 1.6 :bold t)
;(set-face-attribute 'org-level-4 nil :height 1.4 :bold t)



;; add the org-pomodoro-mode-line to the global-mode-string
(unless global-mode-string (setq global-mode-string '("")))
(unless (memq 'org-pomodoro-mode-line global-mode-string)
  (setq global-mode-string (append global-mode-string
                                   '(org-pomodoro-mode-line))))


;; auto toggle todo status
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; pomodoro tech setting
(use-package org-pomodoro
  :ensure t
  :commands (org-pomodoro)
  :config
  (setq alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil))))
  (setq org-pomodoro-length 25)
  (setq org-pomodoro-short-break-length 5)
  (setq org-pomodoro-long-break-length 15)
  (setq org-pomodoro-format " ⏰  %s ")
  (setq org-pomodoro-long-break-format "  ☕☕☕  %s ")
  (setq org-pomodoro-short-break-format "  ☕  %s ")
  (setq org-pomodoro-ticking-sound-p nil)
  )

;  (add-hook 'org-pomodoro-finished-hook
;	(lambda ()
;		(notify-send-linux "Time for a break.")))
;  (add-hook 'org-pomodoro-break-finished-hook
;	(lambda ()
;        (notify-send-linux "Ready for Another?")))
;  (add-hook 'org-pomodoro-long-break-finished-hook
;	(lambda ()
;		(notify-send-linux "Ready for Another?")))
;  (add-hook 'org-pomodoro-killed-hook    
;	(lambda ()
;		(notify-send-linux "One does not simply kill a pomodoro!")))
;; pomodoro notify send
;(defun notify-send-linux (message)
;  (call-process "/bin/bash" nil 0 nil
;		"-c"
;		(concat "notify-send -i ~/org/timeout/emacs.png " "\"" message "\"")))




;; change a good appearance of todo items
(use-package org-bullets
  :init
  :config
  (setq org-bullets-bullet-list '("☯" "✿" "✚" "◉" "❀"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(use-package org-alert
  :defer t
  :config
  (progn
    (setq alert-default-style 'libnotify)
    ))

;; org files include in agenda view
(when *win64*
  (defvar org-icloud-path "c:/Users/devin/org/"))
(when *linux*
  (defvar org-icloud-path "/home/devin/org/"))

(defvar ep-work-org (concat org-icloud-path "work.org"))
(defvar ep-learning-org (concat org-icloud-path "learning.org"))
(defvar ep-personal-org (concat org-icloud-path "personal.org"))
(defvar ep-inbox-org (concat org-icloud-path "inbox.org"))
(defvar ep-habit-org (concat org-icloud-path "habit.org"))

(setq org-agenda-files (list ep-work-org
			     ep-learning-org
			     ep-personal-org
			     ep-inbox-org
			     ep-habit-org))
(setq org-archive-location (concat  "/Users/deyuhua/Workspace/Archive/Orgs/" "%s_archive::"))

;; org caputer settings
(setq org-default-notes-file ep-inbox-org)
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline ep-inbox-org "代办事项")
         "* TODO %?\n %i\n")))

(setq org-refile-targets
      '((ep-learning-org :maxlevel . 1)
        (ep-work-org :maxlevel . 1)
	(ep-personal-org :maxlevel . 1)
	(ep-habit-org :maxlevel . 1)))

;; open agenda view when emacs startup
(defun agenda-view()
  (interactive)
  (progn
    (org-agenda 'a "a")
    (delete-other-windows)))

;; emacs启动时查看安排
(add-hook 'emacs-startup-hook 'agenda-view)
;; open agenda view every hour
;; (run-at-time "0 sec" 3600 'agenda-view)


;; 设置org-moded代码块支持的语言
(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)
   (lisp . t)
   (emacs-lisp . t)))


(provide 'init-org)
