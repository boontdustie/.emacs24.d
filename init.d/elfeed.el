(require 'elfeed)

(global-set-key (kbd "C-x w") 'elfeed)

	     (add-hook 'elfeed-new-entry-hook
		       (elfeed-make-tagger :before "4 weeks ago"
					   :remove 'unread))
	     (setq elfeed-db-directory  (concat gpk-emacs-temporal-directory "elfeed")
		   elfeed-search-filter "@4-weeks-old +unread "
		   elfeed-search-title-max-width 100)
