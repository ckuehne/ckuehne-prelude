;; ckuehne: install latest org
;; cd src
;; git clone git://orgmode.org/org-mode.git
;; cd org
;; git checkout maint # change to maintenance branch
;; make config
;; change local.mk
;;   SUDO= # empty, in order to not install as root into /usr/local
;;   prefix	= /usr/local/share

;; make up2 # this is the 'update git, install all' goal
;; rm /usr/local/share/info/emacs/org.info.gz (this gets only installed if
;; HOMEBREW_KEEP_INFO variable is set (HOMEBREW_KEEP_INFO should be set)

;; capture notess
(global-set-key "\C-cc" 'org-capture)



(provide 'ckuehne-orgmode)
;;; ckuehne-orgmode.el ends here
