(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
 "e" 'find-file
 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "l" 'load-file)

(evil-leader/set-leader ",")
