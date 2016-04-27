(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'whitespace-cleanup)

(defun no-trailing-whitespace ()
  (setq show-trailing-whitespace nil))

(add-hook 'elfeed-setup-hook
          'no-trailing-whitespace)
(add-hook 'mu4e-view-mode-hook
          'no-trailing-whitespace)
(add-hook 'minibuffer-setup-hook
          'no-trailing-whitespace)
(add-hook 'help-mode-hook
          'no-trailing-whitespace)
