;;;; popwin.el
;; http://d.hatena.ne.jp/m2ym/20110120
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:close-popup-window-timer-interval 0.5)
(push '("^\\*helm.*\\*$" :height 0.5 :regexp t :position bottom) popwin:special-display-config)
;; (push '("helm" :height 0.5 :regexp t :position bottom) popwin:special-display-config)
(push '("*Swoop*" :height 0.5 :position bottom) popwin:special-display-config)
(push '("*Warnings*" :height 0.5) popwin:special-display-config)
(push '("*Procces List*" :height 0.5) popwin:special-display-config)
(push '("*Messages*" :height 0.5) popwin:special-display-config)
(push '("*Backtrace*" :height 0.5) popwin:special-display-config)
(push '("*Compile-Log*" :height 0.5 :noselect t) popwin:special-display-config)
(push '("*Remember*" :height 0.5) popwin:special-display-config)
(push '("*All*" :height 0.5) popwin:special-display-config)
(push '(flycheck-error-list-mode :height 0.5 :regexp t :position bottom) popwin:special-display-config)
;; direx
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)

(provide 'init-popwin)
