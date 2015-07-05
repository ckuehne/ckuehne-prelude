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


;; (add-hook 'ediff-prepare-buffer-hook 'f-ediff-prepare-buffer-hook-setup)
;; (defun f-ediff-prepare-buffer-hook-setup ()
;;   ;; specific modes
;;   (cond ((eq major-mode 'org-mode)
;;          (f-org-vis-mod-maximum))
;;         ;; room for more modes
;;         )
;;   ;; all modes
;;   (setq truncate-lines nil))
;; (defun f-org-vis-mod-maximum ()
;;   "Visibility: Show the most possible."
;;   (cond
;;    ((eq major-mode 'org-mode)
;;     (visible-mode 1)  ; default 0
;;     (setq truncate-lines nil)  ; no `org-startup-truncated' in hook
;;     (setq org-hide-leading-stars t))  ; default nil
;;    (t
;;     (message "ERR: not in Org mode")
;;     (ding))))

;; diff hooks for org mode
;; http://www.mail-archive.com/emacs-orgmode@gnu.org/msg74623.html
(add-hook 'ediff-select-hook 'f-ediff-org-unfold-tree-element)
(add-hook 'ediff-unselect-hook 'f-ediff-org-fold-tree)
;; Check for org mode and existence of buffer
(defun f-ediff-org-showhide(buf command &rest cmdargs)
  "If buffer exists and is orgmode then execute command"
  (if buf
      (if (eq (buffer-local-value 'major-mode (get-buffer buf)) 'org-mode)
          (save-excursion (set-buffer buf) (apply command cmdargs)))
    )
  )

(defun f-ediff-org-unfold-tree-element ()
  "Unfold tree at diff location"
  (f-ediff-org-showhide ediff-buffer-A 'org-reveal)  
  (f-ediff-org-showhide ediff-buffer-B 'org-reveal)  
  (f-ediff-org-showhide ediff-buffer-C 'org-reveal)  
  )
;;
(defun f-ediff-org-fold-tree ()
  "Fold tree back to top level"
  (f-ediff-org-showhide ediff-buffer-A 'hide-sublevels 1)  
  (f-ediff-org-showhide ediff-buffer-B 'hide-sublevels 1)  
  (f-ediff-org-showhide ediff-buffer-C 'hide-sublevels 1)  
  )

;; add some Koma classes to the available orgmode LaTeX export classes
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("scrreprt"
               "\\documentclass{scrreprt}"
               ;; ("\\part{%s}" . "\\part*{%s}")
                ("\\chapter{%s}" . "\\chapter*{%s}")
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                )
             '("scrartcl"
               "\\documentclass{scrartcl}"
               ;; ("\\part{%s}" . "\\part*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ))

(provide 'ckuehne-orgmode)
;;; ckuehne-orgmode.el ends here
