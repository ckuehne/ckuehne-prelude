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


;; capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Documents/gtd/todo.org" "Captured")
         "* TODO %?\n %i")
        ("j" "Journal" entry (file+datetree "~/Documents/gtd/org/journal.org")
         "* %?\nEntered on %U\n %i")
        ("m" "Memo to myself" entry (file "~/Documents/gtd/org/memos_to_myself.org")
         "* %?\n %i")
        ("d" "Ideas/Snippets/Thoughts dissertation" entry (file "~/Documents/gtd/org/ideas_dis\
sertation.org")
         "* %?\n %i")
        ("p" "notes peersim chapter" entry (file+headline "~/Documents/_uni/diss/draft/dissnote\
s.org" "Peersim")
         "* %?\n %i")
        ("b" "Useful Bash commands" entry (file "~/Documents/gtd/org/useful_bash_cmds.org")
         "* %?\n %i")
        ("r" "Recipes" entry (file "~/Documents/gtd/recipes.org")
         "* %?\n %i")
        ))

(provide 'ckuehne-orgmode)
;;; ckuehne-orgmode.el ends here
