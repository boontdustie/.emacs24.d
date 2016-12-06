(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
 "e" 'find-file
 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "l" 'load-file
 "c" 'string-rectangle
 "/" 'comment-or-uncomment-region
 "s" 'counsel-ag
 "i" 'ivy-resume)

(evil-leader/set-leader ",")
