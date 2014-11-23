;; expand-region
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; multiple-cursors
(setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(with-eval-after-load "mutilple-cursors"
  (require 'mc-interactive-insert-numbers)
  (define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode)
  (define-key mc/keymap (kbd "C-s") 'phi-search)
  (define-key mc/keymap (kbd "C-r") 'phi-search-backward))

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)

;; move-text
(move-text-default-bindings)

(provide 'init-edit-util)
