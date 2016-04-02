;; http://company-mode.github.io/

(eval-after-load 'company
  '(push 'company-robe company-backends))

;;(add-hook 'after-init-hook 'global-company-mode)
(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(global-set-key (kbd "\t") 'transpose-windows)
(setq company-idle-delay 0.5)

