;; OS X specific settings. Copied from prelude.

;; On OS X Emacs doesn't use the shell PATH if it's not started from
;; the shell. Let's fix that:
(prelude-ensure-module-deps '(exec-path-from-shell))
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(menu-bar-mode 1)


(provide 'ckuehne-osx)
;;; ckuehne-osx.el ends here
