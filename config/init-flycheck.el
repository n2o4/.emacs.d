(dolist (hook '(ruby-mode-hook
                css-mode-hook
                typescript-mode-hook
                json-mode-hook))
  (add-hook hook 'flycheck-mode))

(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 10)

(with-eval-after-load 'flycheck
  (require 'projectile)
  (defcustom flycheck-tslintrc-file-name "./config/tslint.json"
    "Customize config file name"
    :type 'string)

  (flycheck-def-config-file-var flycheck-tslintrc typescript-tslint flycheck-tslintrc-file-name
    :safe #'string)

  (flycheck-define-checker typescript-tslint
    "Use tslint to flycheck TypeScript code."
    :command ("tslint"
              "-f" source
              "-c" (eval (projectile-expand-root flycheck-tslintrc-file-name))
              "-t" "prose")
    :error-patterns ((warning (file-name) "[" line ", " column "]: " (message)))
    :modes typescript-mode)

  (add-to-list 'flycheck-checkers 'typescript-tslint)

  ;; flycheck-color-mode-line
  (custom-set-faces
   '(flycheck-color-mode-line-error-face ((t (:background "red3" :foreground "#efefef" :weight normal))))
   '(flycheck-color-mode-line-info-face ((t (:inherit (flycheck-fringe-info default) :background "DodgerBlue3" :foreground "#efefef" :weight normal))))
   '(flycheck-color-mode-line-warning-face ((t (:background "yellow3" :foreground "black" :weight normal)))))
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(provide 'init-flycheck)
