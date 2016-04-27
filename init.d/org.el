(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))

;;;; ORG-MODE: Behavior and key map for opening the agenda
(defun gpk-pop-to-org-agenda (split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda-list)
  (when (not split)
    (delete-other-windows)))

(define-key global-map (kbd "C-c a") 'gpk-pop-to-org-agenda)

(setq org-capture-templates
      '(("t" "My TODO task format." entry
         (file "todo.org")
         "* TODO [#B] %? %^G
      SCHEDULED: %t
       ")
        ("l" "Links" entry
          (file "links.org")
          "* LINK %a")
        ("c" "calendar" entry
         (file "~/git/me/org/me/cal.org" "Calendar")
        "* TODO %?")
       ("e" "email" entry (file+headline "~/git/me/org/email.org" "Email")
        "* TODO [#B] %a
       SCHEDULED: %t")))

;;;; ORG-MODE: Behavior and key-map for capturing tasks
(defun gpk-org-task-capture ()
 "Capture a task with my default template."
  (interactive)
    (org-capture nil "t"))

(defun gpk-org-link-capture ()
 "Capture a link with my default template."
  (interactive)
    (org-capture nil "l"))

(defun gpk-org-email-capture ()
 "Capture an email with my default template."
  (interactive)
    (org-capture nil "e"))

(defun gpk-org-cal-capture ()
 "Capture an cal deadline with my default template."
  (interactive)
    (org-capture nil "c"))

(define-key global-map (kbd "C-c t") 'gpk-org-task-capture)
(define-key global-map (kbd "C-c e") 'gpk-org-email-capture)
(define-key global-map (kbd "C-c c") 'gpk-org-cal-capture)

;;;; ORG-MODE: Setting up where agenda/todo files go
;;(setq org-agenda-files '("~/git/me/org/"))

(setq org-agenda-files
   (quote
    ("/Users/boontdustie/git/her/org/"
     "/Users/boontdustie/git/her/org/org-earth/"
     "/Users/boontdustie/git/her/org/org-earth/committees"
     "/Users/boontdustie/git/her/org/org-earth/committees/outreach/"
     "/Users/boontdustie/git/her/org/org-earth/committees/programming/"
     "/Users/boontdustie/git/her/org/org-earth/committees/operations/"
     "/Users/boontdustie/git/her/org/org-earth/committees/business/"
     "/Users/boontdustie/git/me/"
     "/Users/boontdustie/git/wrk/"
     )))

(setq org-default-notes-file "~/git/me/org/todo.org")
(setq org-directory "~/git/me/org")

;; Collect all .org from my Org directory and subdirs
(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'") ; default value
(defun load-org-agenda-files-recursively (dir) "Find all directories in DIR."
   (unless (file-directory-p dir) (error "Not a directory `%s'" dir))
   (unless (equal (directory-files dir nil org-agenda-file-regexp t) nil)
      (add-to-list 'org-agenda-files dir)
    )
    (dolist (file (directory-files dir nil nil t))
       (unless (member file '("." ".."))
          (let ((file (concat dir file "/")))
            (when (file-directory-p file)
              (load-org-agenda-files-recursively file)
              )
            )
          )
        )
      )
(load-org-agenda-files-recursively "~/git/me/org/")

(setq org-refile-targets
  '((nil :maxlevel . 9)
     (org-agenda-files :maxlevel . 9)))

;;;; ORG-MODE: Other customizations
(setq org-agenda-text-search-extra-files '(agenda-archives))
(setq org-blank-before-new-entry '((heading . t)
                                    (plain-list-item . t)))
(setq org-enforce-todo-dependencies t)
(setq org-log-done (quote time))
(setq org-log-redeadline (quote time))
(setq org-log-reschedule (quote time))
(setq org-hide-emphasis-markers t)
(setq org-agenda-timegrid-use-ampm t)

;;;; ORG-MODE: Evil key mapping
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "j"         'org-agenda-next-line)
            (define-key org-agenda-mode-map "k"         'org-agenda-previous-line)
            (define-key org-agenda-mode-map "n"         'org-agenda-next-date-line)
            (define-key org-agenda-mode-map "p"         'org-agenda-previous-date-line)
            (define-key org-agenda-mode-map ":"         'org-agenda-set-tags)
            (define-key org-agenda-mode-map (kbd "RET") 'org-agenda-switch-to)
            ))

;;;; ORG-MODE: Auto insert when capturing tasks
(add-hook 'org-capture-mode-hook
          (lambda ()
            (evil-insert-state)))
(put 'erase-buffer 'disabled nil)

(setq org-agenda-skip-scheduled-if-done t)

(setq org-agenda-tag-filter-preset '("-backlog"))

(setq org-agenda-custom-commands
      '(("W" "Work Agenda"
         ((tags-todo "wrk")
           (delete-other-windows)))
       ("w" "Work Agenda Now"
         ((tags-todo "wrk:now")
           (delete-other-windows)))
        ("H" "Hollow Earth Agenda"
         ((tags-todo "her")
           (delete-other-windows)))
        ("h" "Hollow Earth Agenda"
         ((tags-todo "her:now")
           (delete-other-windows)))
        ("M" "My todo"
         ((tags-todo "me")
           (delete-other-windows)))
        ("m" "My todo now"
         ((tags-todo "me:now")
           (delete-other-windows)))
        ("n" "Now Agenda"
         ((tags-todo "now")
           (delete-other-windows)))))

(global-set-key "\C-cf" 'org-agenda)

(setq org-agenda-skip-deadline-prewarning-if-scheduled 3)

(define-key global-map (kbd "C-c D") 'org-decrypt-entry)
(define-key global-map (kbd "C-c C-a") 'org-attach)
(define-key global-map (kbd "C-c C-O") 'org-attach-open-in-emacs)
