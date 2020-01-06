;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)


;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 更改显示字体大小, 16pt
(set-face-attribute 'default nil :height 140)

;; 去掉自动备份文件
(setq make-backup-files nil)

;; 高亮当前行
(global-hl-line-mode 1)

;; 隐藏mode-line
;(setq-default mode-line-format nil)

;; 行号标注
(maybe-require-package 'window-numbering)
(window-numbering-mode t)

;; 快捷键提示模式
(maybe-require-package 'which-key)
(which-key-mode 1)

;; 简化yes或no
(fset 'yes-or-no-p 'y-or-n-p)

;; 关闭自己产生的保存未见
(setq auto-save-default nil)

(maybe-require-package 'popwin)
(require 'popwin)
(popwin-mode 1)

;; 设置默认编码
(set-language-environment "utf-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-buffer-file-coding-system 'utf-8);;默认buffer编码是utf-8,(写文件)
(prefer-coding-system 'utf-8)

;; 关闭光标闪烁功能
(blink-cursor-mode 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("c:/Users/devin/org/work.org" "c:/Users/devin/org/learning.org" "c:/Users/devin/org/personal.org" "c:/Users/devin/org/inbox.org")))
 '(package-selected-packages
   (quote
    (vscode-icon dired-sidebar clj-refactor linum-relative flycheck-clojure cider elein cljsbuild-mode clojure-mode paredit company-php smarty-mode php-mode ox-gfm erlang which-key window-numbering doom-modeline solarized-theme markdown-mode evil-nerd-commenter evil-surround evil-leader evil fullframe magit-todos git-timemachine gitconfig-mode gitignore-mode git-blamed intero haskell-mode youdao-dictionary iedit expand-region popwin company hungry-delete swiper counsel smartparens js2-mode nodejs-repl exec-path-from-shell darkburn-theme use-package org-bullets org-pomodoro org-alert htmlize dracula-theme helm-ag go-mode company-go aggressive-indent highlight-indent-guides slime magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
