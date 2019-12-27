(maybe-require-package 'all-the-icons)
(maybe-require-package 'doom-modeline)
(require 'all-the-icons)
(require 'doom-modeline)
(doom-modeline-mode 1)

(setq doom-modeline-env-version t)
;; Or for individual languages
(setq doom-modeline-env-enable-python t)
(setq doom-modeline-env-enable-ruby t)
(setq doom-modeline-env-enable-perl t)
(setq doom-modeline-env-enable-go t)
(setq doom-modeline-env-enable-elixir t)
(setq doom-modeline-env-enable-rust t)

(provide 'init-doom-modeline)
