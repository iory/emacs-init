(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'cl)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/bin/")
(add-to-list 'load-path "~/.emacs.d/elpa/")

;;; keyboard customiz
(global-set-key "\C-h" 'delete-backward-char)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;;　scratchの初期メッセージ消去
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


;; smartparents
(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
