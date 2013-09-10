(defvar dot-emacs-dot-d (file-name-directory load-file-name)
  "The root dir of the user configurations.")

(defvar ckuehne-personal-dir (expand-file-name "personal" dot-emacs-dot-d)
  "This directory is for my personal configuration.")
(defvar pieces-of-prelude-dir (expand-file-name "pieces-of-prelude" dot-emacs-dot-d)
  "Pieces of the core functionality of prelude.")
(defvar prelude-savefile-dir (expand-file-name "savefile" dot-emacs-dot-d)
  "This folder stores all the automatically generated save/history-files.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

;; add config directories to Emacs's `load-path'
(add-to-list 'load-path pieces-of-prelude-dir)
(add-to-list 'load-path ckuehne-personal-dir)

;; functionality taken directly from prelude
(require 'prelude-packages)
(require 'prelude-core)

;; my configs
(require 'ckuehne-ui)
(require 'ckuehne-editor)
(require 'ckuehne-global-keybindings)
(require 'ckuehne-auctex)
(require 'ckuehne-orgmode)

;; OSX specific settings
;; (when (eq system-type 'darwin)
;; (require 'ckuehne-osx))


;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)
