;; Require and Load Evil Mode
(require 'evil)
(evil-mode t)

(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)

(evil-define-key 'normal org-mode-map (kbd "<") #'org-do-promote)
(evil-define-key 'normal org-mode-map (kbd ">") #'org-do-demote)
(evil-define-key 'normal org-mode-map (kbd "M-<") #'org-promote-subtree)
(evil-define-key 'normal org-mode-map (kbd "M->") #'org-demote-subtree)
