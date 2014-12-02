(setq load-path (append '("~/.emacs.d/elisp"
                          "~/.emacs.d/config"
                          "~/.emacs.d/auto-install"
                          "~/.emacs.d/ddskk/site-lisp"
                          )
                        load-path))

;; function add to load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "repositories")

(setq repositories-dir
      (expand-file-name "repositories" user-emacs-directory))
(setq resource-dir
      (expand-file-name "resource" user-emacs-directory))

(setq is-mac (eq system-type 'darwin))
(setq is-linux (eq window-system 'x))
(setq load-prefer-newer t)

(require 'init-cask)
(require 'init-mac)
(require 'init-basic)
(require 'init-defun)
(require 'init-keybind)
(require 'init-dired)
(require 'init-recentf)
(require 'init-auto-complete)
(require 'init-window)
(require 'init-popwin)
(require 'init-elisp)
(require 'init-undo)
(require 'init-grep)
(require 'init-search)
(require 'init-html)
(require 'init-bm)
(require 'init-twitter)
(require 'init-migemo)
(require 'init-smartrep)
(require 'init-view)
(require 'init-buffer)
(require 'init-org)
(require 'init-ruby)
(require 'init-scala)
(require 'init-javascript)
(require 'init-typescript)
(require 'init-html)
(require 'init-markdown)
(require 'init-flycheck)
(require 'init-highlight)
(require 'init-log)
(require 'init-jump)
(require 'init-util)
(require 'init-edit-util)
(require 'init-helm)
(require 'init-eshell)
(require 'init-git)
(require 'init-skk)
(require 'init-yasnippet)
(require 'init-hatena)
(require 'init-modeline)
