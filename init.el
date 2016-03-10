;; Directories and file names
(setq abg-emacs-init-file (or load-file-name buffer-file-name))
(setq abg-emacs-config-dir
            (file-name-directory abg-emacs-init-file))
(setq user-emacs-directory abg-emacs-config-dir)
(setq abg-elisp-dir (expand-file-name "elisp" abg-emacs-config-dir))
(setq abg-elisp-external-dir
            (expand-file-name "external" abg-elisp-dir))
(setq abg-themes-dir
            (expand-file-name "themes" abg-elisp-dir))
(setq abg-init-dir
            (expand-file-name "init.d" abg-emacs-config-dir))

;; I hate putting package-specific config in this file, but this line
;; MUST come before Org is loaded
(setq org-replace-disputed-keys t)

;; Load all the other
(if (file-exists-p abg-init-dir)
    (dolist (file (directory-files abg-init-dir t "\.el$"))
      (load file)))

;; General
(setq help-window-select t) ;; Automatically select help files
(setq make-backup-files nil) ;; Don't make backup files

(setq vc-follow-symlinks nil) ;; Just warn about following git controlled symlinks

(setq large-file-warning-threshold nil) ;; Stop complaining about large TAGS file

(linum-mode t) ;; Show line number
(setq linum-format "%4d\u007C ") ;; Format line number and space

;;;; Load the theme
(load-theme 'manoj-dark)

;; save/restore opened files and windows config
(desktop-save-mode 1) ; 0 for o
