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

;; from the auctex info docs:
;; If you want to make AUCTeX aware of style files and multi-file
;; documents right away, insert the following in your `.emacs' file.
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

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

;; from http://tex.stackexchange.com/a/64570
(defun my-run-latex ()
  (interactive)
  (TeX-save-document (TeX-master-file))
  (TeX-command "LaTeX" 'TeX-master-file -1))

;; My own fill paragraph that switches between filling the paragraph or
;; putting each sentence on single line.  The latter works well with
;; diffs.

;; From
;; http://pleasefindattached.blogspot.de/2011/12/emacsauctex-sentence-fill-greatly.html
(defadvice LaTeX-fill-region-as-paragraph (around LaTeX-sentence-filling)
  "Start each sentence on a new line."
  (let ((from (ad-get-arg 0))
        (to-marker (set-marker (make-marker) (ad-get-arg 1)))
        tmp-end)
    (message "Execute LaTeX-sentence-filling.")
    (while (< from (marker-position to-marker))
      (forward-sentence)
      ;; might have gone beyond to-marker --- use whichever is smaller:
      (ad-set-arg 1 (setq tmp-end (min (point) (marker-position to-marker))))
      ad-do-it
      (ad-set-arg 0 (setq from (point)))
      (unless (or
               (bolp)
               (looking-at "\\s *$"))
        (LaTeX-newline)))
    (set-marker to-marker nil)))

;; From http://ergoemacs.org/emacs/modernization_fill-paragraph.html
;; With (ad-deactivate 'LaTeX-fill-region-as-paragraph)
;; and (ad-deactivate 'LaTeX-fill-region-as-paragraph) added by me
;; to facilitate LaTeX-sentence-filling advice from above.
(defun compact-uncompact-block ()
  "Remove or add line ending chars on current paragraph.
This command is similar to a toggle of `fill-paragraph'.
When there is a text selection, act on the region."
  (interactive)

  ;; This command symbol has a property “'stateIsCompact-p”.
  (let (currentStateIsCompact (bigFillColumnVal 90002000) (deactivate-mark nil))
    ;; 90002000 is just random. you can use `most-positive-fixnum'

    (save-excursion
      ;; Determine whether the text is currently compact.
      (setq currentStateIsCompact
            (if (eq last-command this-command)
                (get this-command 'stateIsCompact-p)
              (if (> (- (line-end-position) (line-beginning-position)) fill-column) t nil) ) )

      (if (region-active-p)
          (if currentStateIsCompact
              (fill-region (region-beginning) (region-end))
            (let ((fill-column bigFillColumnVal))
              (fill-region (region-beginning) (region-end))) )
        (if currentStateIsCompact
            (progn
              (ad-deactivate 'LaTeX-fill-region-as-paragraph)
              (fill-paragraph nil))
          (progn
            (ad-activate 'LaTeX-fill-region-as-paragraph)
          (let ((fill-column bigFillColumnVal))
            (fill-paragraph nil)) ) ) )

      (put this-command 'stateIsCompact-p (if currentStateIsCompact nil t)) ) ) )

;; Save and build in one command. With optional view.
;; Based on http://stackoverflow.com/a/14717941.
;; Save and build only is useful when I write LaTeX with
;; with Emacs and a pdf viewer side by side and the view is already open.
(defun build-view(&optional view)
  (interactive)
  (let ((TeX-save-query nil)) 
    (TeX-save-document (TeX-master-file)))
  (setq build-proc (TeX-command "LaTeX" 'TeX-master-file -1))
  (if view
      (set-process-sentinel  build-proc  'build-sentinel-view)
  (set-process-sentinel  build-proc  'build-sentinel)))

(defun build-sentinel (process event)    
  (if (not (string= event "finished\n"))
    (message "Errors! Check with C-`")))

(defun build-sentinel-view (process event)    
  (if (string= event "finished\n") 
      (TeX-view)
    (message "Errors! Check with C-`")))


(defun reftex-format-cref (label def-fmt)
  (format "\\cref{%s}" label))

(setq reftex-format-ref-function 'reftex-format-cref)


(defun my-LaTeX-hook ()
  (local-set-key (kbd "s-r") 'build-view)
  (local-set-key (kbd "<f5>") (lambda() (interactive) (build-view t)))
  (local-set-key (kbd "M-q") 'compact-uncompact-block)
  )

(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)

;; Fontification
;; http://tex.stackexchange.com/a/86119
;; http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html
;; http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
        ;; cleveref
        ("cref" "{")
        ("Cref" "{")
        ("cpageref" "{")
        ("Cpageref" "{")
        ("cpagerefrange" "{")
        ("Cpagerefrange" "{")
        ("crefrange" "{")
        ("Crefrange" "{")
        ("labelcref" "{")))

;; Cleveref with AUCTeX
;; http://tex.stackexchange.com/a/119273
(eval-after-load
    "latex"
  '(TeX-add-style-hook
       "cleveref"
     (lambda ()
       (if (boundp 'reftex-ref-style-alist)
	   (add-to-list
	    'reftex-ref-style-alist
	    '("Cleveref" "cleveref"
	      (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
       (add-to-list 'reftex-ref-style-default-list "Cleveref")
       (TeX-add-symbols
	'("cref" TeX-arg-ref)
	'("Cref" TeX-arg-ref)
	'("cpageref" TeX-arg-ref)
	'("Cpageref" TeX-arg-ref)))))

(provide 'ckuehne-auctex)
;;; ckuehne-auctex.el ends here
