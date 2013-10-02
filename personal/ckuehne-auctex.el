;; to install auctex for an existing brew emacs installation:
;;   git clone git://git.sv.gnu.org/auctex.git; cd auctex
;;   ./autogen.sh
;;   ./configure --with-emacs=usr/local/bin/emacs --with-texmf-dir=/usr/local/share/texmf/
;;      --with-lispdir=/usr/local/share/emacs/site-lisp
;;   make
;;   make install



;; load
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; activate AUCTeX-RefTeX interface; see C-h i m RefTeX m auctex
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode

;; prelude defaults for latex mode
(turn-on-auto-fill)
(abbrev-mode +1)

;; set default latex to pdflatex
(setq latex-run-command "pdflatex")
(setq TeX-PDF-mode t)

;; un-fontify
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 'color)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font
(custom-set-faces
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 )
;; Exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
      '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))

;; The following works on Mac OS X only.
;; PDF syncing. Don't forget to activate syncing in Skim.
;; source: http://tex.stackexchange.com/q/11613
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(setq TeX-source-correlate-method 'synctex)

(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-expand-list
                         '("%q" skim-make-url))))

(defun skim-make-url () (concat
                         (TeX-current-line)
                         " "
                         (expand-file-name (funcall file (TeX-output-extension) t)
                                           (file-name-directory (TeX-master-file)))
                         " "
                         (buffer-file-name)))
(setq TeX-view-program-list
      '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %q")))

(setq TeX-view-program-selection '((output-pdf "Skim")))

(provide 'ckuehne-auctex)
;;; ckuehne-auctex.el ends here
