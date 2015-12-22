(require 'cl)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar installing-package-list
  '(
    ;; package list to use
    whitespace
    smartparens
    rainbow-delimiters
    yaml-mode
    cmake-mode
    cmake-project
    ))

;; automatically install
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
(add-to-list 'load-path "/opt/ros/hydro/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
;; (require 'rosemacs-config)

;; inhibit startup screen
(setq inhibit-startup-screen t)

;; delete initial scratch message
(setq initial-scratch-message "")


;; tab->space
(setq-default tab-width 4 indent-tabs-mode nil)

;; whitespace settings
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)
(global-set-key (kbd "C-h") 'delete-backward-char)

(global-set-key "\C-h" 'delete-backward-char)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; ctrl-k で改行コードも含めて行を削除
(setq kill-whole-line t)

;; regionを[delete]で一括削除
(delete-selection-mode t)

;; リージョンが活性化していればリージョン削除
;; 非活性であれば、直前の単語を削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'kill-region-or-backward-kill-word)


(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)

;; smartparents
;; (require 'smartparens-config)
;; (smartparens-global-mode t)
;; (show-smartparens-global-mode t)

;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

(setq
   ;; クリップボードでコピー＆ペーストできるようにする
   x-select-enable-clipboard t
   ;; PRIMARY selectionを使う(Windowsでは対象外)
   x-select-enable-primary t
   ;; クリップボードでコピー・カットした文字列を
   ;; キルリングにも保存させる
   save-interprogram-paste-before-kill t
   ;; エラー時などはベル音ではなくて画面を1回点滅させる
   visible-bell t
   ;; バックアップファイルはカレントディレクトリではなく
   ;; ~/.emacs.d/backups 以下に保存する
   backup-directory-alist `(("." . ,(concat user-emacs-directory
                                            "backups"))))


; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/saved-places"))

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)


;; Makefile-mode
(setq auto-mode-alist
      (append '(("Makefile\\..*$" . makefile-gmake-mode)
                ("Makefile_.*$" . makefile-gmake-mode)
                ) auto-mode-alist))
;; cmake
(require 'cmake-project)

;; cmake-mode
(require 'cmake-mode)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
        (append
            '(("CMakeLists\\.txt\\'" . cmake-mode))
               '(("\\.cmake\\'" . cmake-mode))
                  auto-mode-alist))

(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

(setq auto-mode-alist
      (cons (cons "\\.launch" 'xml-mode) auto-mode-alist))

;; C++ style
(defun add-c++-mode-conf ()
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0)
  (show-paren-mode t))
(add-hook 'c++-mode-hook 'add-c++-mode-conf)

;; C style
(defun add-c-mode-common-conf ()
  (c-set-style "stroustrup")
  (show-paren-mode t)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0))
(add-hook 'c-mode-common-hook 'add-c-mode-common-conf)
