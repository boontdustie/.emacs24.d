;; http://company-mode.github.io/
:
(eval-after-load 'company
  '(push 'company-robe company-backends))

(add-hook 'after-init-hook 'global-company-mode)
