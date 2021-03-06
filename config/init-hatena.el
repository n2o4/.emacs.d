;; http://d.hatena.ne.jp/tarao/20130110/1357821338
(when (require 'hatena-markup-mode nil t)
  (setq hatena:d:major-mode 'hatena:markup-mode))
(when (require 'hatena-multi-mode nil t)
  (add-hook 'hatena:markup-mode-hook #'hatena:multi-mode))

(autoload 'hatena:d:new "hatena-diary"
  "List Hatena::Diary new entries in a buffer." t)
(autoload 'hatena:d:list "hatena-diary"
  "List Hatena::Diary blog entries in a buffer." t)
(autoload 'hatena:d:list-draft "hatena-diary"
  "List Hatena::Diary draft entries in a buffer." t)
(with-eval-after-load "hatena-diary"
  (load (expand-file-name ".hatena-credentials.gpg" resource-dir)))

(global-set-key (kbd "C-c d") 'hatena:d:new)

(provide 'init-hatena)
