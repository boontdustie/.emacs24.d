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

(defun elfeed-entry-as-html-link ()
  "Store an http link to an elfeed entry"
  (when (equal major-mode 'elfeed-show-mode)
    (let ((description (elfeed-entry-title elfeed-show-entry))
          (link (elfeed-entry-link elfeed-show-entry)))
      (org-store-link-props
       :type "http"
       :link link
       :description description))))

(add-hook 'org-store-link-functions 'elfeed-entry-as-html-link)
