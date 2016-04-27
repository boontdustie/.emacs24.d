(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
 "e" 'find-file
 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "l" 'load-file
 "c" 'string-rectangle
 "/" 'comment-or-uncomment-region)

(evil-leader/set-leader ",")
