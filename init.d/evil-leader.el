(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
 "e" 'find-file
 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "l" 'load-file
 "c" 'string-rectangle)

(evil-leader/set-leader ",")
