;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-modes (append ac-modes '(objc-mode)))

(require 'auto-complete-clang-async)
(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable (expand-file-name "~/.emacs.d/bin/clang-complete"))
  (setq ac-sources (append '(ac-source-clang-async) ac-sources))
  (setq ac-clang-cflags (mapcar (lambda (item)
                                  (concat "-I" (expand-file-name item)))
                                  (split-string "~/local/llvm/lib/clang/3.4/include")))
  (setq ac-clang-cflags (append '("-std=c++1y") ac-clang-cflags))
  (ac-clang-launch-completion-process))
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)

;; (defun my-ac-cc-mode-setup ()
;;tなら自動で補完画面がでる．nilなら補完キーによって出る
(setq ac-auto-start t)
;; (setq ac-clang-prefix-header "~/Dropbox/emacs.d/stdafx.pch")
(setq ac-clang-flags
      '("-std=c++11" "-w" "-ferror-limit" "1"))
;;(setq ac-clang-flags '("-w" "-ferror-limit" "1"))
(setq ac-sources (append '(ac-source-clang
			   ac-source-yasnippet
			   ac-source-gtags)
			 ac-sources))

(defun my-ac-config ()
  (global-set-key "\M-/" 'ac-start)
  ;; C-n/C-p で候補を選択
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)

  (setq-default ac-sources '(ac-source-abbrev
			     ac-source-dictionary
			     ac-source-words-in-same-mode-buffers))
  (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(my-ac-config)

;;補完キー指定
;; (ac-set-trigger-key "TAB")
;;ヘルプ画面が出るまでの時間（秒）
(setq ac-quick-help-delay 0.1)
