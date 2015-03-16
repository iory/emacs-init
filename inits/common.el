;; ------------------------------------------------------------------------
;; @ general
;; common lisp

;; C-x f でhome directoryから
(cd "~/")
(require 'cl)

;;back up file を作らない
(setq make-backup-files nil)

;; package.elの設定
(when (require 'package nil t)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))


;; 文字コード
(set-language-environment "Japanese")
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (prefer-coding-system 'utf-8-unix)
         (set-default-coding-systems 'utf-8-unix)
         (setq file-name-coding-system 'sjis)
         (setq locale-coding-system 'utf-8))
        ((eq ws 'ns)
         (require 'ucs-normalize)
         (prefer-coding-system 'utf-8-hfs)
         (setq file-name-coding-system 'utf-8-hfs)
         (setq locale-coding-system 'utf-8-hfs))))

;; Windowsで英数と日本語にMeiryoを指定
;; Macで英数と日本語にRictyを指定
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (set-face-attribute 'default nil
                             ;;:family "Meiryo"  ;; 英数
                             :family "Ricty Diminished Discord"
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; 日本語
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Ricty"  ;; 英数
                             :height 120)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty")))))  ;; 日本語
(set-foreground-color "#55ff55")

;; load-path
(setq load-path
      (append
       (list (expand-file-name "~/Dropbox/emacs.d/elisp")) load-path))

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;;　scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ツールバー非表示
;;(tool-bar-mode -1)

;;　メニューバーを非表示
;;(menu-bar-mode -1)

; スクロールバー非表示
;;(set-scroll-bar-mode nil)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
		    :foreground "#55ff55"
		    :height 0.7)

;; 背景色 and 文字色
(set-background-color "black")
(set-foreground-color "#55ff55")

;; ;; 括弧の範囲を強調表示
;; (show-paren-mode t)
;; (setq show-paren-deray 0)
;; (setq show-paren-style 'expresion)

;; 括弧の範囲職
;; (set-face-background 'show-paren-match-face "#500")

;; 選択領域の色
(set-face-background 'region "#555")

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; 編集場所を記憶する
(load "saveplace")
(setq-default save-place t)

;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 行間
(setq-default line-spacing 0)

;; フレームの透明度
;;(set-frame-parameter (selected-frame) 'alpha '(0.85))

;; モードラインに行番号を表示
(line-number-mode t)

;; モードラインに列番号表示
(column-number-mode t)

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; autoinstall
(add-to-list 'load-path (expand-file-name "~/Dropbox/emacs.d/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/Dropbox/emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/Dropbox/emacs.d/auto-install/")
(auto-install-compatibility-setup)


;; compile キーのショートカット
(define-key mode-specific-map "c" 'compile)

;; ctrl-k で改行コードも含めて行を削除
(setq kill-whole-line t)

;; regionを[delete]で一括削除
(delete-selection-mode t)

;; C-hにBackspaceを割り当て(M-hでヘルプは表示できる)
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; C-lに置き換えを割り当て
(global-set-key (kbd "C-l") 'replace-regexp)

;; C-tをタブ切り替え
(define-key global-map (kbd "C-t") 'other-window)

(auto-insert-mode)
(setq auto-insert-directory "~/Dropbox/emacs.d/insert/")
(define-auto-insert "\\.cpp$" "c_plusplus-template.cpp")
(define-auto-insert "\\.c$" "c-template.c")
(define-auto-insert "\\.py$" "py-template.py")

;; 行末のwhitespaceを削除
(setq delete-trailing-whitespace-exclude-patterns (list "\\.md$" "\\.markdown$"))

(defun delete-trailing-whitespace-with-exclude-pattern ()
  (interactive)
  (cond ((equal nil (loop for pattern in delete-trailing-whitespace-exclude-patterns
                          thereis (string-match pattern buffer-file-name)))
         (delete-trailing-whitespace))))

(add-hook 'before-save-hook 'delete-trailing-whitespace-with-exclude-pattern)



;; ファイル末尾の改行を削除
;; http://www.emacswiki.org/emacs/DeletingWhitespace
(defun my-delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file."
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

(add-hook 'before-save-hook 'my-delete-trailing-blank-lines)

;; tabをspaceに変換
(setq-default tab-width 4 indent-tabs-mode nil)

;; 音を消す
(setq visible-bell t)

;; ファイルを探すときに大文字小文字を区別しない
(setq completion-ignore-case t)

;; メニューバーを消す、ツールバーを消す
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 改行とともにインデント
(global-set-key "\C-m" 'newline-and-indent)

;; 自動改行off
(setq text-mode-hook 'turn-off-auto-fill)

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)

(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-vertically-n 3)))
(global-set-key "\C-x#" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))

(setq windmove-wrap-around t)
(windmove-default-keybindings)


;; veiw-mode
(setq view-read-only t)
(defvar pager-keybind
      `( ;; vi-like
        ("h" . backward-word)
        ("l" . forward-word)
        ("j" . next-line)
        ("k" . previous-line)
        (";" . gene-word)
        ("b" . scroll-down)
        (" " . scroll-up)
        ;; w3m-like
        ("m" . gene-word)
        ("i" . win-delete-current-window-and-squeeze)
        ("w" . forward-word)
        ("e" . backward-word)
        ("(" . point-undo)
        (")" . point-redo)
        ("J" . ,(lambda () (interactive) (scroll-up 1)))
        ("K" . ,(lambda () (interactive) (scroll-down 1)))
        ;; bm-easy
        ("." . bm-toggle)
        ("[" . bm-previous)
        ("]" . bm-next)
        ;; langhelp-like
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ))

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))
;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)


(setq default-frame-alist
      (append
       (list
        '(background-color . "black")
        '(foreground-color . "#55FF55")
        '(cursor-color . "#00AA00")
        )
       default-frame-alist)
      )

;; リージョンが活性化していればリージョン削除
;; 非活性であれば、直前の単語を削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'kill-region-or-backward-kill-word)

(define-prefix-command 'windmove-map)
    (global-set-key (kbd "C-q") 'windmove-map)
    (define-key windmove-map "b" 'windmove-left)
    (define-key windmove-map "n" 'windmove-down)
    (define-key windmove-map "p" 'windmove-up)
    (define-key windmove-map "f" 'windmove-right)

 (defun split-window-conditional ()
      (interactive)
      (if (> (* (window-height) 2) (window-width))
          (split-window-vertically)
        (split-window-horizontally)))
(define-key windmove-map "s" 'split-window-conditional)


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
