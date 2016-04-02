;; Load projectile
(projectile-global-mode)

(setq projectile-known-projects-file
            (expand-file-name "projectile-bookmarks.eld" gpk-emacs-temporal-directory))

(setq projectile-completion-system 'ido)
