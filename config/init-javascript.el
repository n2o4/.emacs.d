;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))

(with-eval-after-load 'js2-mode
  (add-hook 'js2-mode-hook '(lambda () (setq mode-name "js2")))
  (setq js2-auto-indent-p t)
  (setq-default js2-global-externs '("require" "assert" "__dirname" "console" "JSON" "define" "$" "_"))
  (js2-imenu-extras-setup)
  (js2r-add-keybindings-with-prefix "C-c C-m")

  ;; jasmineを除外
  (dolist (jasmine '("jasmine" "describe" "context" "beforeEach" "it" "expect" "afterEach" "spyOn" "spySuperOn"))
    (add-to-list 'js2-global-externs jasmine))

  (define-key js2-mode-map (kbd "C-c C-o") nil) ; enable helm-swoop
  (define-key js2-mode-map (kbd "C-c C-r") 'js2r-rename-var))

(with-eval-after-load 'json-mode
  (setq json-reformat:pretty-string? t))

;; tern.js
(autoload 'tern-mode "tern.el" nil t)
;; (add-hook 'js2-mode-hook '(lambda () (tern-mode t)))
(with-eval-after-load 'tern
  (require 'tern-auto-complete)
  (tern-ac-setup))

;; coffee-mode
(defun my/coffee-mode-hook ()
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2)))

(add-hook 'coffee-mode-hook 'my/coffee-mode-hook)

(provide 'init-javascript)
