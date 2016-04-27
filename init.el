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

(setq backup-directory-alist
      `((".*" . , gpk-emacs-temporal-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,gpk-emacs-temporal-directory t)))

;; General
(setq help-window-select t) ;; Automatically select help files
(setq vc-follow-symlinks nil) ;; Just warn about following git controlled symlinks

(setq large-file-warning-threshold nil) ;; Stop complaining about large TAGS file

;; Load all elisp files in ./init.d
(if (file-exists-p gpk-init-dir)
    (dolist (file (directory-files gpk-init-dir t "\\.el$"))
      (load file)))

(defun is-in-terminal()
      (not (display-graphic-p)))

(if (is-in-terminal)
    ;; Set up 'custom' system for graphical interface
    (setq custom-file (expand-file-name "emacs-customizations.el" gpk-emacs-config-dir))
    ;; else
    (setq custom-file (expand-file-name "emacs-customizations-graphical.el" gpk-emacs-config-dir)))

(load custom-file)
(load-theme 'wombat)

(defun remove-background()
  (set-face-background 'default "unspecified-bg" (selected-frame)))

(defun on-after-init ()
  (if (is-in-terminal)
      (remove-background)))

(if (is-in-terminal)
  (remove-background)
  ;; Remove background from themes since I use a transparent background in iTerm
  ;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
  (add-hook 'window-setup-hook 'on-after-init))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
