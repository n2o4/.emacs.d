(ac-config-default)
(setq ac-use-quick-help t
      ac-quick-help-delay 1.0
      ac-use-menu-map t
      ac-use-fuzzy t
      ac-auto-start nil
      ac-ignore-case nil
      ac-comphist-file (expand-file-name "ac-comphist.dat" resource-dir))

(add-to-list 'ac-dictionary-directories
             (expand-file-name  "ac-dict" user-emacs-directory))

(setq-default ac-sources '(ac-source-dictionary
                           ac-source-words-in-buffer
                           ac-source-words-in-same-mode-buffers
                           ac-source-words-in-all-buffer
                           ac-source-imenu
                           ac-source-dabbrev))

(ac-set-trigger-key "TAB")

(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)
(define-key ac-completing-map (kbd "C-m") 'ac-complete)

(dolist (mode '(text-mode
                coffee-mode
                scss-mode
                less-css-mode
                fundamental-mode
                org-mode))
  (add-to-list 'ac-modes mode))

(dolist (hook '(scss-mode-hook
                less-css-mode-hook))
  (add-hook hook 'ac-css-mode-setup))

(ac-ispell-setup)
(dolist (hook '(text-mode-hook git-commit-mode-hook))
  (add-hook hook 'ac-ispell-ac-setup))

(with-eval-after-load 'yasnippet
  (setq-default ac-sources (append '(ac-source-yasnippet) ac-sources)))

(provide 'init-auto-complete)
