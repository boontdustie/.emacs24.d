;; Require and Load Evil Mode
(require 'evil)
(evil-mode t)

(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
