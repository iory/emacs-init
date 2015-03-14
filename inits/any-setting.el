(add-to-list 'load-path "~/Dropbox/emacs.d/elisp/yatex/")

;; emacs-nav
;;(add-to-list 'load-path "~/Dropbox/emacs.d/emacs-nav/")
;;(require 'nav)
;;(global-set-key "\C-x\C-d" 'nav-toggle)

(require 'smartparens-config)
(smartparens-global-mode t)

;; undoreeの設定
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; redo+.el
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; smartparents
(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)


;; volatile-highlights
;; undo や redo した場所がhighlightされる
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

(require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")


;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; haskel
(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode-2.8.0")

(require 'haskell-mode)
(require 'haskell-cabal)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
(put 'downcase-region 'disabled nil)


;; arduino-mode
(setq load-path (cons "~/Dropbox/emacs.d/elisp/arduino-mode/" load-path))
(load "arduino-mode")
(setq auto-mode-alist (cons '("\\.pde$" . arduino-mode) auto-mode-alist))


(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


;; Makefile-mode
(setq auto-mode-alist
      (append '(("Makefile\\..*$" . makefile-gmake-mode)
		("Makefile_.*$" . makefile-gmake-mode)
		) auto-mode-alist))
;; cmake
(require 'cmake-project)

;; ;; C# c#
;; (require 'csharp-mode)
;; (setq auto-mode-alist
;;    (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-clang-language-standard "c++11")
;; Python
(add-hook 'python-mode-hook 'flycheck-mode)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

(setq auto-mode-alist
      (cons (cons "\\.launch" 'xml-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))

;; smart-newline
(define-key global-map (kbd "C-m") 'smart-newline)

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)


;;; この前にmigemoの設定が必要
(require 'helm-migemo)
;;; この修正が必要
(eval-after-load "helm-migemo"
  '(defun helm-compile-source--candidates-in-buffer (source)
     (helm-aif (assoc 'candidates-in-buffer source)
         (append source
                 `((candidates
                    . ,(or (cdr it)
                           (lambda ()
                             ;; Do not use `source' because other plugins
                             ;; (such as helm-migemo) may change it
                             (helm-candidates-in-buffer (helm-get-current-source)))))
                   (volatile) (match identity)))
       source)))


(require 'helm-swoop)
;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)

;;; 検索結果をcycleしない、お好みで
(setq helm-swoop-move-to-line-cycle nil)

(cl-defun helm-swoop-nomigemo (&key $query ($multiline current-prefix-arg))
  "シンボル検索用Migemo無効版helm-swoop"
  (interactive)
  (let ((helm-swoop-pre-input-function
         (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol)))))
    (helm-swoop :$source (delete '(migemo) (copy-sequence (helm-c-source-swoop)))
                :$query $query :$multiline $multiline)))
;;; C-M-:に割り当て
(global-set-key (kbd "C-M-:") 'helm-swoop-nomigemo)

;;; [2014-11-25 Tue]
(when (featurep 'helm-anything)
  (defadvice helm-resume (around helm-swoop-resume activate)
    "helm-anything-resumeで復元できないのでその場合に限定して無効化"
    ad-do-it))

;;; ace-isearch
(global-ace-isearch-mode 1)


;; mwim
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;; (require 'howdoi)
;; ;;; 質問も表示する(なぜデフォルトで無効だし？)
;; (setq howdoi-display-question t)
;; ;;; *How do I*表示後にURLを表示する
;; (defun howdoi-show-url (&rest ignore)
;;   (interactive)
;;   (message "%s" howdoi-current-stackoverflow-url))
;;(advice-add 'howdoi-pop-answer-to-buffer-callback :after 'howdoi-show-url)
;;; cで現在のURLを表示する
;;(define-key howdoi-mode-map (kbd "c") 'howdoi-show-url)

(require 'hiwin)
(hiwin-activate)
