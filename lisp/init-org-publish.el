;; ************************************************************
;; 	Must Load ox-publish package
;; ************************************************************
;(use-package org
;  :ensure org-plus-contrib
;  :defer t)

(require 'ox-md)
(require 'ox-publish)


;; ************************************************************
;; 	Setup export theme
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; (use-package dracula-theme)

(defun pkg-with-theme (theme fn &rest args)
  (let ((current-themes custom-enabled-themes))
    (mapcar #'disable-theme custom-enabled-themes)
    (load-theme theme t)
    (let ((result (apply fn args)))
      (mapcar #'disable-theme custom-enabled-themes)
      (mapcar (lambda (theme) (load-theme theme t)) current-themes)
      result)))

(advice-add #'org-export-to-file :around (apply-partially #'pkg-with-theme 'dracula))
(advice-add #'org-export-to-buffer :around (apply-partially #'pkg-with-theme 'dracula))

;; ************************************************************
;; 	Force publish all
;; ************************************************************
(use-package htmlize)
(defun pkg-org-publish ()
  (interactive)
  (progn
    (org-publish-remove-all-timestamps)
    (org-publish-all t)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; 	Load aboutme org-file
;; ************************************************************
(defun pkg-file-contents (filename)
  "Return the contents of FILENAME."
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string)))


;; ************************************************************
;; 	Change default sitemap index
;; ************************************************************
;; sitemap function
(defun pkg-org-publish-org-sitemap (title list)
  "Sitemap generation function."
  (concat (format "#+TITLE: %s\n" title)
	  "#+OPTIONS: toc:nil\n"
	  "#+KEYWORDS:技术博客,技术思考,机器学习,深度学习,IoT,边缘计算,Kubernets,容器技术\n"
	  "#+DESCRIPTION:前沿技术博客,记录技术生活点滴,Dont't Panic\n\n"
	  "* Articals\n"
	  (replace-regexp-in-string "\*" " " (org-list-to-subtree '("hardware","test")))
	  "\n\n"
	  (pkg-file-contents (expand-file-name "~/.emacs.d/lisp/aboutme.org"))
	  ))

(defun pkg-org-publish-org-sitemap-format (entry style project)
  "Custom sitemap entry formatting: add date"
  (cond ((not (directory-name-p entry))
         (format "- [[file:%s][ %s]]"
                 entry
                 (org-publish-find-title entry project)))
        ((eq style 'tree)
         ;; Return only last subdir.
         (concat "+ "
	 	 (capitalize (file-name-nondirectory (directory-file-name entry)))
	 	 "/"))
        (t entry)))

;; ************************************************************
;; 	Notebook related settings
;; ************************************************************
;; insert src block easily
(setq org-publish-project-alist
      '(("orgfiles"
         :base-directory "/home/devinkin/Documents/gitHubPages/notebooks/"
         :base-extension "org"
         :publishing-directory "/home/devinkin/gitHubPages/notebooks/"
         :publishing-function org-html-publish-to-html
         :headline-levels 1
         :section-numbers nil
         :with-toc t
	 :html-head-include-scripts nil	 
         :html-head "
<meta name=\"baidu-site-verification\" content=\"VsK7KMhTM1\" />
<link rel=\"stylesheet\" href=\"/style/solarized-dark.css\" type=\"text/css\"/>
<link rel=\"stylesheet\" href=\"https://use.fontawesome.com/releases/v5.6.3/css/all.css\" integrity=\"sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/\" crossorigin=\"anonymous\">
<link href=\"/images/favicon.ico\" rel=\"icon\">
<script
     src=\"https://code.jquery.com/jquery-3.3.1.min.js\"
     integrity=\"sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=\"
     crossorigin=\"anonymous\">
</script>
<script>
(function(){
    if (location.hostname !== 'huadeyu.tech') {
        return;
    }
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName(\"script\")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
<script>
var _hmt = _hmt || [];
(function() {
  if (location.hostname !== \"huadeyu.tech\") {
    return;
  }
  var hm = document.createElement(\"script\");
  hm.src = \"https://hm.baidu.com/hm.js?0f9fde052ac9166486f2761c80b2bc93\";
  var s = document.getElementsByTagName(\"script\")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
"
	 ;; :html-preamble t
         :recursive t
         :with-email "devinkin@163.com"
         :with-title t
         :html-html5-fancy t
         :auto-sitemap t
	 ;:sitemap-function pkg-org-publish-org-sitemap
	 ;:sitemap-format-entry pkg-org-publish-org-sitemap-format
         :sitemap-filename "index.org"
         :sitemap-title "Happy Hacking!"
         )

        ("images"
	 :recursive t
         :base-directory "/home/devinkin/Documents/gitHubPages/notebooks/images/"
         :base-extension "jpg\\|gif\\|png\\|jpeg\\|ico"
         :publishing-directory "/home/devinkin/gitHubPages/notebooks/images/"
         :publishing-function org-publish-attachment)

        ("style"
         :base-directory "/home/devinkin/Documents/gitHubPages/notebooks/style/"
         :base-extension "css\\|el\\|js"
         :publishing-directory "/home/devinkin/gitHubPages/notebooks/style/"
         :publishing-function org-publish-attachment)

        ("fonts"
         :base-directory "/home/devinkin/Documents/gitHubPages/notebooks/fonts/"
         :base-extension "eot\\|woff2\\|woff\\|ttf\\|svg"
         :publishing-directory "/home/devinkin/gitHubPages/notebooks/fonts/"
         :publishing-function org-publish-attachment)	

        ("website" :components ("orgfiles" "images" "style" "fonts"))))

;; static page setup
(setq org-html-preamble t)
(setq org-html-postamble "
<div id=\"footer\">
  <div>Created By OrgMode; <span id=\"love\" style=\"color: #ff79c6; font-size: 30px;\">♥</span><a href=\"https://zh.wikipedia.org/wiki/Emacs\">#EMACS</a></div>
  <div>Edited By 哈比 (Habi) </div>
</div>
<div id=\"icons\">
   <div id=\"home\">
     <a href=\"/index.html\">Home</a>
   </div>
   <div id=\"github\">
     <a href=\"https://github.com/devinkin\" target=\"_blank\">Github</a>
   </div>
  <div id=\"mail\">
    <a href=\"mailto:devinkin@163.com\">Email</a>
  </div>
</div>
<div class=\"back-to-top\">
  <a href=\"#top\"><i class=\"far fa-caret-square-up\"></i></a>
</div>
<script type=\"text/javascript\">
    var offset = 220;
    var duration = 500;
    jQuery(window).scroll(function() {
        if (jQuery(this).scrollTop() > offset) {
            jQuery('.back-to-top').fadeIn(duration);
        } else {
            jQuery('.back-to-top').fadeOut(duration);
        }
    });
   jQuery('.back-to-top').click(function() {
        jQuery('body,html').animate({scrollTop:0},500);
        return false;
   });
   let timer = true;
   setInterval(function() {
	if (timer)
          $(\"#love\").animate({fontSize: 18})
	else
	  $(\"#love\").animate({fontSize: 24})
	timer = !timer 
   }, 300);
</script>
<script>
  (function() {
      if (location.pathname === '/' || location.pathname === '/index.html') {
      	return;
      }
      var main = document.querySelector('#postamble');
      var script = document.createElement('script');
      script.src='https://utteranc.es/client.js'
      script.setAttribute('repo', 'devinkin/devinkin.github.io');
      script.setAttribute('issue-term', 'pathname');
      main.appendChild(script);
  })();  
</script>
");;; org-publish.el --- publish related org-mode files as a website

;; Copyright (C) 2006, 2007  Free Software Foundation, Inc.

;; Author: David O'Toole <dto@gnu.org>
;; Keywords: hypermedia, outlines
;; Version:

;; $Id: org-publish.el,v 1.80 2007/03/22 02:31:03 dto Exp dto $

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by

(provide 'init-org-publish)
