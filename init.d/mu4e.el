(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)

;; default
(setq mu4e-maildir "~/.mail")

(setq mu4e-compose-complete-only-personal nil)

(setq mu4e-drafts-folder "/gmail/[Gmail].Drafts")
(setq mu4e-sent-folder   "/gmail/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/gmail/[Gmail].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/gmail/INBOX"         . ?i)
       ("/gmail/[Gmail].Sent Mail"   . ?s)
       ("/gmail/[Gmail].Trash"       . ?t)
       ("/gmail/[Gmail].All Mail"    . ?a)))

;; send mail
(setq
 send-mail-function 'smtpmail-send-it
 message-send-mail-function 'smtpmail-send-it
 user-mail-address "garrett@hollowearthradio.org"
 user-full-name  "Garrett Kelly"
 smtpmail-starttls-credentials '(("smtp.gmail.com" "587" nil nil))
 smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 587
 smtpmail-debug-info t
 starttls-extra-arguments nil
 starttls-gnutls-program "/usr/local/bin/gnutls-cli"
 starttls-extra-arguments nil
 starttls-use-gnutls t
 mu4e-compose-signature
    (concat
      "Garrett Kelly, Director\n"
      "http://www.hollowearthradio.org\n")
 )

(setq mu4e-compose-complete-addresses 't)

(add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq mu4e-get-mail-command "offlineimap -f INBOX") ;; or fetchmail, or ...

(setq message-kill-buffer-on-exit t)

(setq mu4e-view-prefer-html t)
