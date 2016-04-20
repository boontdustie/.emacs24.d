;; ELFEED

(evil-set-initial-state 'elfeed-show 'emacs)
(evil-define-key 'normal elfeed-search-mode-map
  ;; fetch feed updates; default: G
  "o" 'elfeed-update
  ;; refreash view of feed listing; default: g
  "O" 'elfeed-search-update--force
  ;; filter
  "f" 'elfeed-search-live-filter
  ;; reset to default filter
  "F" '(lambda () (interactive) (elfeed-search-set-filter "@3-weeks-ago +unread "))
  ;; open url in specified browser
  "b" 'elfeed-search-browse-url
  ;; read current entry or selected (remove unread tag)
  "h" 'elfeed-search-untag-all-unread
  ;; enter show mode on entry
  "i" 'elfeed-search-show-entry
  ;; mark current entry or selected unread
  "u" 'elfeed-search-tag-all-unread
  ;; add a tag to current entry or selected
  "a" 'elfeed-search-tag-all
  ;; star entries to come back later to and do something about
  "s" '(lambda () (interactive) (elfeed-search-toggle-all '*))
  ;; remove a tag from current entry or selected
  "d" 'elfeed-search-untag-all)

;; mappings for when reading a post
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "RET") 'elfeed-search-browse-url
  "h" 'elfeed-kill-buffer
  ;; next post
  "n" 'elfeed-show-next
  "b" 'elfeed-show-prev
  ;; add a tag to current entry
  "a" 'elfeed-show-tag
  "s" '(lambda () (interactive) (elfeed-search-toggle-all '*))
  "o" 'gpk-org-link-capture
  ;; remove a tag from current entry
  "d" 'elfeed-show-untag)
