(require 'package)


(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
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

(ensure-package-installed
        'ag
        'airline-themes
        'calfw
        'color-theme-zenburn
        'color-theme-wombat
        'company
        'direx
        'elfeed
        'elfeed-goodies
        'elfeed-org
        'erc
        'evil
        'evil-leader
        'evil-magit
        'evil-mu4e
        'evil-numbers
        'evil-org
        'evil-rails
        'fill-column-indicator
        'flx-ido
        'git-gutter
        'grizzl
        'helm
        'helm-ag
        'oauth
        'org
        'org-plus-contrib
        'org-ehtml
        'ox-pandoc
        'popwin
        'powerline-evil
        'projectile
        'robe
        'ruby-hash-syntax
        'simpleclip
        'ssh
        'wc-mode
        'websocket
        'web-mode
        'windresize
        'web-server
        'ws-butler
        )
