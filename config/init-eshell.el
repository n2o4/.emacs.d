; -*- mode: lisp; coding: utf-8 -*-
;;---------------------------------------------------------
;; eshell
;;---------------------------------------------------------
;; マークしたファイルを引数にeshellを起動する
;; Emacs mail magazine
(defun dired-start-eshell (arg)
  "diredで選択されたファイル名がペーストされた状態で、eshellを起動する。"
  (interactive "P")
  (let ((files (mapconcat 'shell-quote-argument
                          (dired-get-marked-files (not arg))
                          " ")))
    (if (fboundp 'shell-pop) (shell-pop) (eshell t))
    (save-excursion (insert " " files))))
(define-key dired-mode-map [remap dired-do-shell-command] 'dired-start-eshell)

;; esh-myparser.el
;; コマンド解釈乗っ取り
;; Emacs mail magazine
(when (require 'esh-myparser nil t)
  ;; (defun eshell-parser/b (str) (eshell-parser/b str "bash"))
  )

;; esh-cmdline-stack.el
;; eshellでコマンドラインスタック機能を実現する
;; Emacs mail magazine
(require 'esh-cmdline-stack nil t)

;; eshellでの実行をbashなどのシェルを利用するように変更
;; Emacs mail magazines
(progn
  (defmacro eval-after-load* (name &rest body)
    (declare (indent 1))
    `(eval-after-load ,name '(progn ,@body)))
  (defun eshell-disable-unix-command-emulation ()
    (eval-after-load* "em-ls"
      (fmakunbound 'eshell/ls))
    (eval-after-load* "em-unix"
      (mapc 'fmakunbound '(eshell/agrep
                           eshell/basename
                           eshell/cat
                           eshell/cp
                           eshell/date
                           eshell/diff
                           eshell/dirname
                           eshell/du
                           eshell/egrep
                           eshell/fgrep
                           eshell/glimpse
                           eshell/grep
                           eshell/info
                           eshell/ln
                           eshell/locate
                           eshell/make
                           eshell/man
                           eshell/mkdir
                           eshell/mv
                           eshell/occur
                           eshell/rm
                           eshell/rmdir
                           eshell/su
                           eshell/sudo
                           eshell/git
                           eshell/time
                           eshell/rake
                           eshell/rspec))))
  (eshell-disable-unix-command-emulation))

;; shell-pop.el and eshell-pop.el
;; Emacs mail magazine
(when (require 'shell-pop nil t)
  (when (require 'eshell-pop nil t)
    (global-set-key (kbd "C-x C-z") 'shell-pop)
    (setq shell-pop-window-height 50) ;; eshell popup window size
    ))

;; キーバインドをshellらしくする
(progn
(defun eshell-in-command-line-p ()
  (<= eshell-last-output-end (point)))
(defmacro defun-eshell-cmdline (key &rest body)
  (let ((cmd (intern (format "eshell-cmdline/%s" key))))
    `(progn
       (add-hook 'eshell-mode-hook
                 (lambda () (define-key eshell-mode-map
(read-kbd-macro ,key) ',cmd)))
       (defun ,cmd ()
         (interactive)
         (if (not (eshell-in-command-line-p))
             (call-interactively (lookup-key (current-global-map)
(read-kbd-macro ,key)))
           ,@body)))))
(defun eshell-history-and-bol (func)
  (delete-region eshell-last-output-end (point-max))
  (funcall func 1)
  (goto-char eshell-last-output-end)))
;; 範囲指定していないとき、C-wで前の単語を削除
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))
;; 前のコマンドの履歴取得
(defun-eshell-cmdline "C-p"
(let ((last-command 'eshell-previous-matching-input-from-input))
  (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))
;; 次のコマンドの履歴取得
(defun-eshell-cmdline "C-n"
(let ((last-command 'eshell-previous-matching-input-from-input))
  (eshell-history-and-bol 'eshell-next-input)))
;; 直前の履歴を取得
(defadvice eshell-send-input (after history-position activate)
(setq eshell-history-index -1))
;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))

(setq eshell-directory-name "~/.emacs.d/resource/.eshell/")

(provide 'init-eshell)