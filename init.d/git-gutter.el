;;; Load git gutter mode
(global-git-gutter-mode +1)

;;;; Customize the git-gutter display
(custom-set-variables
'(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "  "))

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")
