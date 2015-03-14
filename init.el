;; .emacs.d/init.el

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'cl)
(global-set-key (kbd "C-x C-c") 'open-junk-file)
;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
(package-initialize)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    open-junk-file
    tabbar
    helm
    undo-tree
    auto-complete
    auto-complete-clang-async
    smartparens
    popwin
    helm-ag
    redo+
    nav
    volatile-highlights
    lispxmp
    haskell-mode
    cmake-project
    cmake-mode
    yaml-mode
    jedi
    flymake
    flymake-checkers
    flylisp
    flymake-cppcheck
    flycheck
    flycheck-google-cpplint
    direx
    helm-cmd-t
    magit
    git-gutter
    quickrun
    anzu
    yasnippet
    dropdown-list
    slime
    smart-newline
    powerline
    use-package
    helm-swoop
    helm-migemo
    ace-isearch
    migemo
    evil
    powerline-evil
    save-load-path
    mwim
    howdoi
    hiwin
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

(add-to-list 'load-path "~/.emacs.d/site-lisp/trr/")
(autoload 'trr "~/.emacs.d/site-lisp/trr/trr.el" nil t)
(autoload 'trr "/home/iori/.emacs.d/site-lisp/trr/trr.el" nil t)
(add-to-list 'load-path "~/.emacs.d/site-lisp/trr/text")


(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/bin/")
(add-to-list 'load-path "~/.emacs.d/elpa/")

(load "~/Dropbox/emacs.d/common.el")
(load "~/Dropbox/emacs.d/tab.el")
(load "~/Dropbox/emacs.d/direx.el")
(load "~/Dropbox/emacs.d/helm_setting.el")
(load "~/Dropbox/emacs.d/server.el")
(load "~/Dropbox/emacs.d/git.el")
(load "~/Dropbox/emacs.d/utility.el")
(load "~/Dropbox/emacs.d/gauche.el")
(load "~/Dropbox/emacs.d/quickrun_setting.el")
(load "~/Dropbox/emacs.d/python.el")
;;(load "~/Dropbox/emacs.d/ruby.el")
(load "~/Dropbox/emacs.d/auto_complete_setting.el")
(load "~/Dropbox/emacs.d/any_setting.el")

;; font-setting
;; (set-face-attribute 'default nil
;;                     :family "Ricty"
;;                     :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "Ricty Discord" "iso10646-1"))


;; 拡張子が .tex なら yatex-mode に
(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;; YaTeX が利用する内部コマンドを定義する
(setq tex-command "platex2pdf") ;; 自作したコマンドを
(cond
  ((eq system-type 'gnu/linux) ;; GNU/Linux なら
    (setq dvi2-command "evince")) ;; evince で PDF を閲覧
  ((eq system-type 'darwin) ;; Mac なら
    (setq dvi2-command "open -a Preview"))) ;; プレビューで
(add-hook 'yatex-mode-hook '(lambda () (setq auto-fill-function nil)))


;; (setq load-path (cons (expand-file-name
;; "/Applications/Emacs.app/Contents/Resources/site-lisp/yatex")load-path))

;; (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.tex$" . yatex-mode)
;;                 ("\\.ltx$" . yatex-mode)
;;                 ("\\.cls$" . yatex-mode)
;;                 ("\\.sty$" . yatex-mode)
;;                 ("\\.clo$" . yatex-mode)
;;                 ("\\.bbl$" . yatex-mode)) auto-mode-alist))
;; (setq YaTeX-inhibit-prefix-letter t)
;; (setq YaTeX-kanji-code nil)
;; (setq YaTeX-use-LaTeX2e t)
;; (setq YaTeX-use-AMS-LaTeX t)
;; (setq YaTeX-dvipdf-command "/usr/texbin/dvipdfmx")
;; (setq YaTeX-dvi2-command-ext-alist
;;       '(("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))
;; (setq tex-command "/usr/texbin/ptex2pdf -l -ot '-synctex=1'")
;; (setq bibtex-command (cond ((string-match "uplatex" tex-command) "/usr/texbin/upbibtex")
;;                            ((string-match "platex" tex-command) "/usr/texbin/pbibtex")
;;                            ((string-match "lualatex\\|xelatex" tex-command) "/usr/texbin/bibtexu")
;;                            (t "/usr/texbin/bibtex")))
;; (setq makeindex-command (cond ((string-match "uplatex" tex-command) "/usr/texbin/mendex")
;;                               ((string-match "platex" tex-command) "/usr/texbin/mendex")
;;                               ((string-match "lualatex\\|xelatex" tex-command) "/usr/texbin/texindy")
;;                               (t "/usr/texbin/makeindex")))
;; ;(setq dvi2-command "/usr/bin/open -a Preview")
;; ;(setq dvi2-command "/usr/bin/open -a TeXShop")
;; (setq dvi2-command "/usr/bin/open -a Skim")
;; (setq dviprint-command-format "/usr/bin/open -a \"Adobe Reader\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")

;; (setq yatex-mode-load-hook
;;   '(lambda()
;;     (YaTeX-define-begend-key "be" "eqnarray") ; ¥·¥ç¡¼¥È¥«¥Ã¥È¥­¡¼¤ÎÊÑ¹¹
;;     (setq indent-tabs-mode nil)
;;     (setq YaTeX-environment-indent 2)
;;    )
;; )

;; ; ¼«Æ°²þ¹Ô¤òÌµ¸ú²½¤¹¤ë
;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (auto-fill-mode -1)))

;; ;;
;; ;; RefTeX with YaTeX
;; ;;
;; ;(add-hook 'yatex-mode-hook 'turn-on-reftex)
;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (reftex-mode 1)
;;              (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
;;              (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))


;; ;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#f978a43b
;; (defun skim-forward-search ()
;;   (interactive)
;;   (progn
;;     (process-kill-without-query
;;      (start-process
;;       "displayline"
;;       nil
;;       "/Applications/Skim.app/Contents/SharedSupport/displayline"
;;       (number-to-string (save-restriction
;;                           (widen)
;;                           (count-lines (point-min) (point))))
;;       (expand-file-name
;;        (concat (file-name-sans-extension (or YaTeX-parent-file
;;                                              (save-excursion
;;                                                (YaTeX-visit-main t)
;;                                                buffer-file-name)))
;;                ".pdf"))
;;       buffer-file-name))))

;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (define-key YaTeX-mode-map (kbd "C-c s") 'skim-forward-search)))

;; ;; (set-background-color "black")

;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/site-lisp/"))



;; yasnippetを置いているフォルダにパスを通す
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/site-lisp/yasnippet"))

;;自分用のスニペットフォルダと，拾ってきたスニペットフォルダの2つを作っておきます．
;;(一つにまとめてもいいけど)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/plugin/yasnippet-snippets"
        "~/.emacs.d/snippets"
        ))

;; yas起動
(yas-global-mode 1)

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)


(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
			     yas/ido-prompt
			     yas/completing-prompt))


;; SLIMEのロード
(setq inferior-lisp-program "/usr/local/bin/clisp")
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))

;; Apropos
(push '("*slime-apropos*") popwin:special-display-config)
;; Macroexpand
(push '("*slime-macroexpansion*") popwin:special-display-config)
;; Help
(push '("*slime-description*") popwin:special-display-config)
;; Compilation
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
;; Cross-reference
(push '("*slime-xref*") popwin:special-display-config)
;; Debugger
(push '(sldb-mode :stick t) popwin:special-display-config)
;; REPL
(push '(slime-repl-mode) popwin:special-display-config)
;; Connections
(push '(slime-connection-list-mode) popwin:special-display-config)

;; (require 'ac-slime)
;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)


(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))


(setq
   ;; クリップボードでコピー＆ペーストできるようにする
   x-select-enable-clipboard t
   ;; PRIMARY selectionを使う(Windowsでは対象外)
   x-select-enable-primary t
   ;; クリップボードでコピー・カットした文字列を
   ;; キルリングにも保存させる
   save-interprogram-paste-before-kill t
   ;; エラー時などはベル音ではなくて画面を1回点滅させる
   visible-bell t
   ;; バックアップファイルはカレントディレクトリではなく
   ;; ~/.emacs.d/backups 以下に保存する
   backup-directory-alist `(("." . ,(concat user-emacs-directory
                                            "backups"))))

(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)
(put 'set-goal-column 'disabled nil)

;; (require 'evil)
;; (evil-mode t)

;; (require 'powerline-evil)
;; (powerline-evil-face)
