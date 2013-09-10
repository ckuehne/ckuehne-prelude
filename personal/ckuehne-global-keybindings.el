;;; ckuehne-global-keybindings.el 
;;; with large parts copied from Prelude by Bozhidar Batsov

;;; Code:

;;; from prelude-global-keybindings.el

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Window switching. (C-x o goes to the next window)
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window -1))) ;; back one

;; Indentation help
(global-set-key (kbd "C-^") 'prelude-top-join-line)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; If you want to be able to M-x without meta
(global-set-key (kbd "C-x C-m") 'smex)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-l") 'find-library)

;; a complement to the zap-to-char command, that doesn't eat up the target character
(autoload 'zap-up-to-char "misc" "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-Z") 'zap-up-to-char)

;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

(global-set-key [remap kill-whole-line] 'prelude-kill-whole-line)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp
                 isearch-string
               (regexp-quote isearch-string))))))

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; toggle menu-bar visibility
(global-set-key (kbd "<f12>") 'menu-bar-mode)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-=") 'er/expand-region)

;; make C-x C-x usable with transient-mark-mode
(define-key global-map
  [remap exchange-point-and-mark]
  'prelude-exchange-point-and-mark)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; key chords
(require 'key-chord)

(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "JJ" 'prelude-switch-to-previous-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)

(key-chord-mode +1)

;;; others
(global-set-key (kbd "C-c o") 'prelude-open-with)
(global-set-key (kbd "C-c g") 'prelude-google)

;; mimic popular IDEs binding, note that it doesn't work in a terminal session
(global-set-key [(shift return)] 'prelude-smart-open-line)
(global-set-key (kbd "M-o") 'prelude-smart-open-line)
(global-set-key [(control shift return)] 'prelude-smart-open-line-above)
(global-set-key [(control shift up)]  'prelude-move-line-up)
(global-set-key [(control shift down)]  'prelude-move-line-down)
(global-set-key [(meta shift up)]  'prelude-move-line-up)
(global-set-key [(meta shift down)]  'prelude-move-line-down)

(global-set-key (kbd "C-c n") 'prelude-cleanup-buffer)
(global-set-key (kbd "C-c f")  'prelude-recentf-ido-find-file)
(global-set-key (kbd "C-M-\\") 'prelude-indent-region-or-buffer)
(global-set-key (kbd "C-M-z") 'prelude-indent-defun)
(global-set-key (kbd "C-c u") 'prelude-view-url)
(global-set-key (kbd "C-c e") 'prelude-eval-and-replace)
(global-set-key (kbd "C-c s") 'prelude-swap-windows)
(global-set-key (kbd "C-c D") 'prelude-delete-file-and-buffer)
(global-set-key (kbd "C-c d") 'prelude-duplicate-current-line-or-region)
(global-set-key (kbd "C-c M-d") 'prelude-duplicate-and-comment-current-line-or-region)
(global-set-key (kbd "C-c r") 'prelude-rename-file-and-buffer)
(global-set-key (kbd "C-c t") 'prelude-visit-term-buffer)
(global-set-key (kbd "C-c k") 'prelude-kill-other-buffers)
(global-set-key (kbd "C-c TAB") 'prelude-indent-rigidly-and-copy-to-clipboard)
(global-set-key (kbd "C-c +") 'prelude-increment-integer-at-point)
(global-set-key (kbd "C-c -") 'prelude-decrement-integer-at-point)



(provide 'ckuehne-global-keybindings)

;;; ckuehne-global-keybindings.el ends here
