;; ------------------------------------------------------------------------
;; @ general
;; common lisp

(cd "~/")

;; don't make back up file
(setq make-backup-files nil)

;; literal code
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

;; foreground setting
(set-foreground-color "#55ff55")
(global-linum-mode t)
(set-face-attribute 'linum nil
		    :foreground "#55ff55"
		    :height 0.7)

;; selected area's color
(set-face-background 'region "#555")

;; inhibit startup screen
(setq inhibit-startup-screen t)

;; delete initial scratch message
(setq initial-scratch-message "")

;; display full-path on title
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; save save-place
(load "saveplace")
(setq-default save-place t)

;; display recent file
(recentf-mode t)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 3000)

;; save hist
(savehist-mode 1)
(setq history-length 3000)

;; line setting
(setq-default line-spacing 0)
(line-number-mode t)
(column-number-mode t)

;; C-Ret
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; compile key shortcut
(define-key mode-specific-map "c" 'compile)

(setq kill-whole-line t)
(delete-selection-mode t)
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; replace-regexp
(global-set-key (kbd "C-l") 'replace-regexp)

;; C-t as tab change
(define-key global-map (kbd "C-t") 'other-window)

;; delete whitespace
(setq delete-trailing-whitespace-exclude-patterns (list "\\.md$" "\\.markdown$"))
(defun delete-trailing-whitespace-with-exclude-pattern ()
  (interactive)
  (cond ((equal nil (loop for pattern in delete-trailing-whitespace-exclude-patterns
                          thereis (string-match pattern buffer-file-name)))
         (delete-trailing-whitespace))))
(add-hook 'before-save-hook 'delete-trailing-whitespace-with-exclude-pattern)

(defun my-delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file."
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

(add-hook 'before-save-hook 'my-delete-trailing-blank-lines)

;; tab->space
(setq-default tab-width 4 indent-tabs-mode nil)

(setq visible-bell t)

(setq completion-ignore-case t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(global-set-key "\C-m" 'newline-and-indent)
;; smart-newline
(define-key global-map (kbd "C-m") 'smart-newline)

(setq text-mode-hook 'turn-off-auto-fill)

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

(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))
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

;;; Get current path and put it to clipboard
(defun get-current-path-to-clipboard ()
  (interactive)
  (let ((file-path buffer-file-name)
        (dir-path default-directory))
    (cond (file-path
           (kill-new (expand-file-name file-path))
           (message "This file path is on the clipboard!"))
          (dir-path
           (kill-new (expand-file-name dir-path))
           (message "This directory path is on the clipboard!"))
          (t
           (error-message-string "Fail to get path name.")
           ))))
(global-set-key (kbd "C-c C-c p") 'put-current-path-to-clipboard)

(provide 'common)
