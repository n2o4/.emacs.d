;;----------------------------------------------------------------------------
;; package.el
;; http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el
;;----------------------------------------------------------------------------
(require 'package)


(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
;; (defvar marmalade '("marmalade" . "http://marmalade-repo.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives gnu t)
;; (add-to-list 'package-archives marmalade t)
(add-to-list 'package-archives melpa t)

(package-initialize)

;; https://github.com/magnars/.emacs.d/blob/master/setup-package.el
(defun packages-install (&rest packages)
  (mapc (lambda (package)
          (let ((name (car package))
                (repo (cdr package)))
            (when (not (package-installed-p name))
              (let ((package-archives (list repo)))
                (package-initialize)
                (package-install name)))))
        packages)
  (package-initialize)
  (delete-other-windows))

(defun init-install-packages ()
  (packages-install
   (cons 'cl-lib gnu)
   (cons 'melpa melpa)
   (cons 'auto-install melpa)
   (cons 'auto-complete melpa)
   (cons 'fuzzy melpa)
   (cons 'popwin melpa)
   (cons 'bm melpa)
   (cons 'ruby-mode melpa)
   (cons 'robe melpa)
   (cons 'ruby-electric melpa)
   (cons 'ruby-block melpa)
   (cons 'inf-ruby melpa)
   (cons 'ruby-interpolation melpa)
   (cons 'rbenv melpa)
   (cons 'rspec-mode melpa)
   (cons 'rinari melpa)
   (cons 'bundler melpa)
   (cons 'rhtml-mode melpa)
   (cons 'direx melpa)
   (cons 'dsvn melpa)
   (cons 'rainbow-mode gnu)
   (cons 'goto-chg melpa)
   (cons 'maxframe melpa)
   (cons 'color-moccur melpa)
   (cons 'diminish melpa)
   (cons 'magit melpa)
   (cons 'magit-find-file melpa)
   (cons 'git-commit-mode melpa)
   (cons 'gitconfig-mode melpa)
   (cons 'gitignore-mode melpa)
   (cons 'git-messenger melpa)
   (cons 'git-rebase-mode melpa)
   (cons 'gh melpa)
   (cons 'elscreen melpa)
   (cons 'flycheck melpa)
   (cons 'undohist melpa)
   (cons 'point-undo melpa)
   (cons 'quickrun melpa)
   (cons 'all gnu)
   (cons 'all-ext melpa)
   (cons 'replace-from-region melpa)
   (cons 'expand-region melpa)
   (cons 'change-inner melpa)
   (cons 'multiple-cursors melpa)
   (cons 'redo+ melpa)
   (cons 'bash-completion melpa)
   (cons 'yagist melpa)
   (cons 'scala-mode2 melpa)
   (cons 'yaml-mode melpa)
   (cons 'anything melpa)
   (cons 'anything-git-files melpa)
   (cons 'helm melpa)
   (cons 'helm-c-moccur melpa)
   (cons 'helm-projectile melpa)
   (cons 'helm-ls-git melpa)
   (cons 'helm-c-yasnippet melpa)
   (cons 'helm-open-github melpa)
   (cons 'helm-spaces melpa)
   (cons 'helm-git-grep melpa)
   (cons 'helm-dired-recent-dirs melpa)
   (cons 'helm-ag melpa)
   (cons 'helm-ag-r melpa)
   (cons 'helm-descbinds melpa)
   (cons 'helm-rails melpa)
   (cons 'helm-rb melpa)
   (cons 'htmlize melpa)
   (cons 'emmet-mode melpa)
   (cons 'zencoding-mode melpa)
   (cons 'markdown-mode melpa)
   (cons 'markdown-mode+ melpa)
   (cons 'color-moccur melpa)
   (cons 'scratch-log melpa)
   (cons 'session melpa)
   (cons 'savekill melpa)
   (cons 'sticky melpa)
   (cons 'sequential-command melpa)
   (cons 'duplicate-thing melpa)
   (cons 'open-junk-file melpa)
   (cons 'recentf-ext melpa)
   (cons 'viewer melpa)
   (cons 'god-mode melpa)
   (cons 'dash-at-point melpa)
   (cons 'elisp-slime-nav melpa)
   (cons 'eldoc-extension melpa)
   (cons 'paredit melpa)
   (cons 'spaces melpa)
   (cons 'e2wm melpa)
   (cons 'window-layout melpa)
   (cons 'switch-window melpa)
   (cons 'jaunte melpa)
   (cons 'ace-jump-mode melpa)
   (cons 'iy-go-to-char melpa)
   (cons 'imenu-anywhere melpa)
   (cons 'less-css-mode melpa)
   (cons 'scss-mode melpa)
   (cons 'js2-mode melpa)
   (cons 'js2-refactor melpa)
   (cons 'nodejs-repl melpa)
   (cons 'coffee-mode melpa)
   (cons 'wgrep melpa)
   (cons 'wgrep-ag melpa)
   (cons 'grep-a-lot melpa)
   (cons 'ag melpa)
   (cons 'smartrep melpa)
   (cons 'pomodoro melpa)
   (cons 'zlc melpa)
   (cons 'revive melpa)
   (cons 'exec-path-from-shell melpa)
   (cons 'volatile-highlights melpa)
   (cons 'highlight-symbol melpa)
   (cons 'undo-tree melpa)
   (cons 'yasnippet melpa)
   (cons 'dropdown-list melpa)
   (cons 'web-mode melpa)
   (cons 'w3m melpa)
   (cons 'migemo melpa)
   (cons 'anzu melpa)
   ))

(condition-case nil
    (init-install-packages)
  (error
   (package-refresh-contents)
   (init-install-packages)))

;; auto-install.el
(when (require 'auto-install nil t)
 (setq auto-install-directory "~/.emacs.d/auto-install/")
 (auto-install-compatibility-setup)             ; 互換性確保
 )

(provide 'init-elpa)
