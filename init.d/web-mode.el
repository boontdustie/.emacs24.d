;;http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
(setq-default indent-tabs-mode nil)
