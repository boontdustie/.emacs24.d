(require 'elfeed)
(global-set-key (kbd "C-x w") 'elfeed)

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
