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
         (file "me.org")
        "* TODO [#B] %? %^G
       SCHEDULED: %t")))

;;;; ORG-MODE: Behavior and key-map for capturing tasks
(defun gpk-org-task-capture ()
 "Capture a task with my default template."
  (interactive)
    (org-capture nil "t"))

(define-key global-map (kbd "C-c t") 'gpk-org-task-capture)

(setq org-default-notes-file "~/git/me/org/me.org")
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
  '((nil :maxlevel . 14)
     (org-agenda-files :maxlevel . 14)))

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

(setq org-agenda-tag-filter-preset
      (quote ("-backlog" " garrett")))

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
         ((tags-todo "her:garrett:now")
           (delete-other-windows)))
        ("A" "Priority A"
         ((tags-todo "+PRIORITY=\"A\"")
           (delete-other-windows)))
        ("T" "My todo"
         ((tags-todo "me")
           (delete-other-windows)))
        ("t" "My todo now"
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


(setq gpk/org-adjust-tags-column t)

(defun gpk/org-adjust-tags-column-reset-tags ()
  "In org-mode buffers it will reset tag position according to
`org-tags-column'."
  (when (and
         (not (string= (buffer-name) "*Remember*"))
         (eql major-mode 'org-mode))
    (let ((b-m-p (buffer-modified-p)))
      (condition-case nil
          (save-excursion
            (goto-char (point-min))
            (command-execute 'outline-next-visible-heading)
            ;; disable (message) that org-set-tags generates
            (flet ((message (&rest ignored) nil))
              (org-set-tags 1 t))
            (set-buffer-modified-p b-m-p))
        (error nil)))))

(defun gpk/org-adjust-tags-column-now ()
  "Right-adjust `org-tags-column' value, then reset tag position."
  (set (make-local-variable 'org-tags-column)
       (- (- (window-width) (length org-ellipsis))))
  (gpk/org-adjust-tags-column-reset-tags))

(defun gpk/org-adjust-tags-column-maybe ()
  "If `gpk/org-adjust-tags-column' is set to non-nil, adjust tags."
  (when gpk/org-adjust-tags-column
    (gpk/org-adjust-tags-column-now)))

(defun gpk/org-adjust-tags-column-before-save ()
  "Tags need to be left-adjusted when saving."
  (when gpk/org-adjust-tags-column
     (setq org-tags-column 1)
     (gpk/org-adjust-tags-column-reset-tags)))

(defun gpk/org-adjust-tags-column-after-save ()
  "Revert left-adjusted tag position done by before-save hook."
  (gpk/org-adjust-tags-column-maybe)
  (set-buffer-modified-p nil))

; automatically align tags on right-hand side
(add-hook 'window-configuration-change-hook
          'gpk/org-adjust-tags-column-maybe)
(add-hook 'before-save-hook 'gpk/org-adjust-tags-column-before-save)
(add-hook 'after-save-hook 'gpk/org-adjust-tags-column-after-save)
(add-hook 'org-agenda-mode-hook '(lambda ()
                                  (setq org-agenda-tags-column (- (window-width)))))

; between invoking org-refile and displaying the prompt (which
; triggers window-configuration-change-hook) tags might adjust,
; which invalidates the org-refile cache
(defadvice org-refile (around org-refile-disable-adjust-tags)
  "Disable dynamically adjusting tags"
  (let ((gpk/org-adjust-tags-column nil))
    ad-do-it))
(ad-activate 'org-refile)

(setq gpk/org-adjust-tags-column t)

(defun gpk/org-adjust-tags-column-reset-tags ()
  "In org-mode buffers it will reset tag position according to
`org-tags-column'."
  (when (and
         (not (string= (buffer-name) "*Remember*"))
         (eql major-mode 'org-mode))
    (let ((b-m-p (buffer-modified-p)))
      (condition-case nil
          (save-excursion
            (goto-char (point-min))
            (command-execute 'outline-next-visible-heading)
            ;; disable (message) that org-set-tags generates
            (flet ((message (&rest ignored) nil))
              (org-set-tags 1 t))
            (set-buffer-modified-p b-m-p))
        (error nil)))))

(defun gpk/org-adjust-tags-column-now ()
  "Right-adjust `org-tags-column' value, then reset tag position."
  (set (make-local-variable 'org-tags-column)
       (- (- (window-width) (length org-ellipsis))))
  (gpk/org-adjust-tags-column-reset-tags))

(defun gpk/org-adjust-tags-column-maybe ()
  "If `gpk/org-adjust-tags-column' is set to non-nil, adjust tags."
  (when gpk/org-adjust-tags-column
    (gpk/org-adjust-tags-column-now)))

(defun gpk/org-adjust-tags-column-before-save ()
  "Tags need to be left-adjusted when saving."
  (when gpk/org-adjust-tags-column
     (setq org-tags-column 1)
     (gpk/org-adjust-tags-column-reset-tags)))

(defun gpk/org-adjust-tags-column-after-save ()
  "Revert left-adjusted tag position done by before-save hook."
  (gpk/org-adjust-tags-column-maybe)
  (set-buffer-modified-p nil))

; automatically align tags on right-hand side
(add-hook 'window-configuration-change-hook
          'gpk/org-adjust-tags-column-maybe)
(add-hook 'before-save-hook 'gpk/org-adjust-tags-column-before-save)
(add-hook 'after-save-hook 'gpk/org-adjust-tags-column-after-save)
(add-hook 'org-agenda-mode-hook '(lambda ()
                                  (setq org-agenda-tags-column (- (window-width)))))

; between invoking org-refile and displaying the prompt (which
; triggers window-configuration-change-hook) tags might adjust,
; which invalidates the org-refile cache
(defadvice org-refile (around org-refile-disable-adjust-tags)
  "Disable dynamically adjusting tags"
  (let ((gpk/org-adjust-tags-column nil))
    ad-do-it))
(ad-activate 'org-refile)
