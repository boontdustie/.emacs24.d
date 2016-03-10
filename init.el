;; Directories and file names
(setq gpk-emacs-init-file (or load-file-name buffer-file-name))
(setq gpk-emacs-config-dir
      (file-name-directory gpk-emacs-init-file))
(setq user-emacs-directory gpk-emacs-config-dir)
(setq gpk-elisp-dir (expand-file-name "elisp" gpk-emacs-config-dir))
(setq gpk-elisp-external-dir
      (expand-file-name "external" gpk-elisp-dir))
(setq gpk-themes-dir
      (expand-file-name "themes" gpk-elisp-dir))
(setq gpk-init-dir
      (expand-file-name "init.d" gpk-emacs-config-dir))


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

;; Load all elisp files in ./init.d
(if (file-exists-p gpk-init-dir)
    (dolist (file (directory-files gpk-init-dir t "\\.el$"))
      (load file)))
