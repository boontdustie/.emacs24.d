(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(defun ensure-package-installed (&rest packages)
    "Assure every package is installed, ask for installation if it’s not.

  Return a list of installed packages or nil for every skipped package."
    (mapcar
         (lambda (package)
                (if (package-installed-p package)
                           nil
                                  (if (y-or-n-p (format "Package %s is missing. Install it? " package))
                                               (package-install package)
                                                        package)))
            packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
        (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed 'evil
			  'evil-magit
			  'helm
			  'git-gutter
			  'projectile
			  'org
			  'flx-ido
			  'windresize
			  'evil-rails
			  'erc
			  )

;; THINGS TO LOAD ON STARTUP
;; General
(setq help-window-select t) ;; Automatically select help files
(setq make-backup-files nil) ;; Don't make backup files

(setq vc-follow-symlinks nil) ;; Just warn about following git controlled symlinks

(setq large-file-warning-threshold nil) ;; Stop complaining about large TAGS file

(linum-mode t) ;; Show line number
(setq linum-format "%4d\u007C ") ;; Format line number and space

;;;; Load the theme
(load-theme 'manoj-dark)

;; Require and Load Evil Mode
(require 'evil)
(evil-mode t)

;; Load evil-rails
;; https://github.com/antono/evil-rails
;; https://github.com/asok/projectile-rails
(require 'evil-rails)

(require 'evil-magit)

;; Require and load Flx Ido (for fuzzy completion)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)

;; Load git gutter mode
(global-git-gutter-mode +1)

;;;; Customize the git-gutter display
(custom-set-variables
'(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "  "))

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; Load projectile
(projectile-global-mode)

;; Load org mode details
(setq org-todo-keywords
            '((sequence "☛ TODO" "○ IN-PROGRESS" "⚑ WAITING" "|" "✓ DONE" "✗ CANCELED")))

;;;; ORG-MODE: Behavior and key map for opening the agenda
(defun gpk-pop-to-org-agenda (split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda-list)
  (when (not split)
    (delete-other-windows)))

(define-key global-map (kbd "C-c t a") 'gpk-pop-to-org-agenda)

(setq org-capture-templates
      '(("a" "My TODO task format." entry
	 (file "todo.org")
	 "* ☛ TODO %?
      SCHEDULED: %t")))

;;;; ORG-MODE: Behavior and key-map for capturing tasks
(defun gpk-org-task-capture ()
  "Capture a task with my default template."
  (interactive)
    (org-capture nil "a"))

(define-key global-map (kbd "C-c c") 'gpk-org-task-capture)

;;;; ORG-MODE: Setting up where agenda/todo files go
(setq org-agenda-files '("~/git/me/todo"))
(setq org-default-notes-file "~/git/me/todo/todo.org")
(setq org-directory "~/git/me/todo")


;;;; ORG-MODE: Other customizations
(setq org-agenda-text-search-extra-files '(agenda-archives))
(setq org-blank-before-new-entry '((heading . t)
                                    (plain-list-item . t)))
(setq org-enforce-todo-dependencies t)
(setq org-log-done (quote time))
(setq org-log-redeadline (quote time))
(setq org-log-reschedule (quote time))

;;;; ORG-MODE: Evil key mapping
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "j"         'org-agenda-next-line)
            (define-key org-agenda-mode-map "k"         'org-agenda-previous-line)
            (define-key org-agenda-mode-map "n"         'org-agenda-next-date-line)
            (define-key org-agenda-mode-map "p"         'org-agenda-previous-date-line)
            (define-key org-agenda-mode-map "c"         'air-org-agenda-capture)
            (define-key org-agenda-mode-map (kbd "RET") 'org-agenda-switch-to)

            ))

;;;; ORG-MODE: Auto insert when capturing tasks
(add-hook 'org-capture-mode-hook
          (lambda ()
            (evil-insert-state)))
(put 'erase-buffer 'disabled nil)


;; joining && autojoing

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#rubyonrails" "##feminism" "#geekfeminism" "#git" "#ruby" )))

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

				"324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

      (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "boontdustie" :full-name "Garrett Kelly"))))

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC

;; feature for revert split pane config. Call winner-undo 【Ctrl+c ←】 and winner-redo 【Ctrl+c →】
(when (fboundp 'winner-mode)
        (winner-mode 1))

;; save/restore opened files and windows config
(desktop-save-mode 1) ; 0 for o
