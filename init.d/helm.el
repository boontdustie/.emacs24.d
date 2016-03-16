(require 'helm)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x) 
(global-set-key (kbd "M-l") 'helm-buffers-list) ;; quick buffer switch

;; Always open helm at the bottom
(add-to-list 'display-buffer-alist
	     `(,(rx bos "*helm" (* not-newline) "*" eos)
	       (display-buffer-in-side-window)
	       (inhibit-same-window . t)
	                                (window-height . 0.4)))
