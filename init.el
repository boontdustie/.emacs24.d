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

(defvar gpk-emacs-temporal-directory (concat user-emacs-directory "tmp/"))
(unless (file-exists-p gpk-emacs-temporal-directory)
    (make-directory gpk-emacs-temporal-directory))

;; make backup to a designated dir, mirroring the full path
(defun my-backup-file-name (fpath)
    "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
    (let* (
	   (backupRootDir "~/.emacs24.d/tmp/")
           (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir "~")))
	 )
      (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
      backupFilePath
      )
    )
(setq make-backup-file-name-function 'my-backup-file-name)

;; General
(setq help-window-select t) ;; Automatically select help files
(setq vc-follow-symlinks nil) ;; Just warn about following git controlled symlinks

(setq large-file-warning-threshold nil) ;; Stop complaining about large TAGS file

;; Load all elisp files in ./init.d
(if (file-exists-p gpk-init-dir)
    (dolist (file (directory-files gpk-init-dir t "\\.el$"))
      (load file)))

;; Set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" gpk-emacs-config-dir))
(load custom-file)

;; Remove background from themes since I use a transparent background in iTerm
;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; Load desired theme
(load-theme 'wombat)
