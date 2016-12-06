(require 'ivy)
(ivy-mode 1)

;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
(setq ivy-use-virtual-buffers t)

;; number of result lines to display
(setq ivy-height 10)

;; does not count candidates
(setq ivy-count-format "")

;; no regexp by default
(setq ivy-initial-inputs-alist nil)

;; configure regexp engine.
(setq ivy-re-builders-alist
        ;; allow input not in order
        '((t   . ivy--regex-ignore-order)))


(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-b") 'ivy-switch-buffer) ;; quick buffer switch

;; Always open ivy at the bottom
(add-to-list 'display-buffer-alist
             `(,(rx bos "*ivy" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
                                        (window-height . 0.4)))
