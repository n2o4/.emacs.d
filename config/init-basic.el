;; 日本語に設定
(set-language-environment 'Japanese)
;; UTF-8に設定
(prefer-coding-system           'utf-8)
(set-buffer-file-coding-system  'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(set-clipboard-coding-system    'utf-8)
(setq file-name-coding-system   'utf-8)
(setq locale-coding-system      'utf-8)
;; Scrollを１行毎に
(setq scroll-step 1)
(when window-system
  (set-background-color "Black")
  (set-foreground-color "White")
  (set-cursor-color "Gray")
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar nil)
  ;; 現在行を目立たせる
  ;; http://d.hatena.ne.jp/khyiker/20070409/emacs_hl_line
  (global-hl-line-mode) ;デフォルトはこの行だけでOK
  (set-face-background hl-line-face "#222222")

  (add-hook 'window-setup-hook 'toggle-frame-maximized))

(winner-mode t)
;; *scratch*の初期表示メッセージを消す
;; http://d.hatena.ne.jp/mooz/20100318/p1
(setq initial-scratch-message "")
;; tabは2文字分、改行後に自動インデント
(setq-default tab-width 2)
;; tabインデントは使用しない
(setq-default indent-tabs-mode nil)
;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; 行末の空白を表示しないmodeを設定する
;; https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el#L48
(defun my/no-trailing-whitespace ()
  (setq show-trailing-whitespace nil))
(dolist (hook '(twittering-mode-hook
                prodigy-mode-hook
                calendar-mode-hook
                eshell-mode-hook
                eww-mode-hook
                minibuffer-setup-hook))
  (add-hook hook 'my/no-trailing-whitespace))

(defun my/subword-mode ()
  (subword-mode t))

(dolist (hook '(java-mode-hook
                typescript-mode-hook))
  (add-hook hook 'my/subword-mode))

;; カーソルの設定
(custom-set-variables
 '(blink-cursor-mode nil) ;; カーソルの点滅を止める
 '(cursor-type 'box))     ;; カーソルの形状

;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; スクロール時のカーソル位置維持
(setq scroll-preserve-screen-position t)
;; 対応する括弧を光らせる。
(show-paren-mode t)
;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;; オートセーブファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)
;; ロックファイルを作らない
(setq create-lockfiles nil)
;; 削除したらゴミ箱に
(setq delete-by-moving-to-trash t)
;; find-fileのファイル名補完時に大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)
(setq completion-ignore-case t)
;; 選択範囲を色付け
(transient-mark-mode 1)
;; 起動時のメッセージを消す
(setq inhibit-startup-message t)
;;"yes or no"を"y or n"にする
(fset 'yes-or-no-p 'y-or-n-p)
;; メニューバーにファイルパスを表示する
(setq frame-title-format
      (format "%%f - Emacs" (system-name)))

;; 行間を開く
(setq-default line-spacing 0.1)
;; モードラインに時間を表示する
(setq display-time-24hr-format t)
;; 以下の書式に従ってモードラインに日付 時刻を表示する
(setq display-time-string-forms
      '((format "%s/%s/%s(%s) %s:%s"
                year month day
                dayname
                24-hours minutes)))
(setq display-time-day-and-date t)
(display-time)

;; beepを消す
(setq ring-bell-function 'ignore)

;; 終了時にプロセスをkillしていいか聞いてこないようにする
;; http://d.hatena.ne.jp/kitokitoki/20101029/p3
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

;; Emacsを終了時に確認する(誤操作防止)
(setq confirm-kill-emacs 'y-or-n-p)

;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; C-k で改行を含め切り取り
(setq kill-whole-line t)

;; find file (or url) at point
(ffap-bindings)

(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; electric-indent-mode
(electric-indent-mode -1)

;; electric-pair-mode
(electric-pair-mode -1)

;; electric-layout-mode
(electric-layout-mode -1)

;; *complations* バッファにてヘルプメッセージを表示しない．
(setq completion-show-help nil)

;; yankなどでregionで上書きするようにする
(delete-selection-mode t)

(require 'tramp)
(setq tramp-persistency-file-name (expand-file-name "tramp" resource-dir))

(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init-basic)
