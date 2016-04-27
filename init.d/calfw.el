(require 'calfw)
(require 'calfw-org)

(setq cfw:org-agenda-schedule-args '(:deadline))

(global-set-key (kbd "C-x c") 'cfw:open-org-calendar)
