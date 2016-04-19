(require 'elfeed)
(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
        "http://www.terminally-incoherent.com/blog/feed/"
        "http://www.boingboing.net/feed"
        "http://www.daringfireball.net/feeds/main"
        "http://www.thestranger.com/seattle/Rss.xml"
        "http://feeds.gawker.com/lifehacker/full"
        "http://www.reddit.com/r/emacs/.rss"
        "http://www.reddit.com/r/seattle/.rss"))

(add-hook 'elfeed-show-mode-hook (lambda () (setq-local show-trailing-whitespace nil)))
