;;; ckuehne-ui.el UI optimizations and tweaks.
;;; Mostly copied from Emacs Prelude by Bozhidar Batsov.

;;; Commentary:

;; We dispense with most of the point and click UI, reduce the startup noise,
;; configure smooth scolling and a nice theme that's easy on the eyes (zenburn).

;;; Code:

;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode -1)

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " Prelude - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;; use zenburn as the default theme
(load-theme 'zenburn t)

;;; The above code is taken more or less literally from prelude-ui.el
;;; Below is my own stuff.

;; A nice font with an adequate size for my thirty-something eyes.
(setq default-frame-alist '((font . "Monaco-15")))

; (require 'powerline)
; (powerline-default-theme)

(fset 'linebreak-german-to-english
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 46 return 24 113 right backspace return] 0 "%d")) arg)))

;; define function to shutdown emacs server instance
;; from http://www.emacswiki.org/emacs/EmacsAsDaemon
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(provide 'ckuehne-ui)
;;; ckuehne-ui.el ends here
