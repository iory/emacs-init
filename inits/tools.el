;;; tools.el --- my elisp function tools

;; Copyright (C) 2015  iori

;; Author: iori
;; Keywords: elisp

(defun copy-current-line ()
  (interactive)
  (let (start
        end
        (current-pos (point))
        (old-kill-ring (car kill-ring)))
    (cond (mark-active
           (setq start (region-beginning)
                 end   (region-end)))
          (t
           (beginning-of-line)
           (setq start (point))
           (end-of-line)
           (setq end (point))))
    (kill-ring-save start end)
    (if (equal old-kill-ring (car kill-ring))
        (progn
          (end-of-line)
          (open-line 1)
          (forward-line)
          (yank)
          (goto-char current-pos)
          (forward-line))
      (goto-char current-pos))
    ))

(defun select-current-line ()
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))


(global-set-key (kbd "M-p") 'copy-current-line)
(global-set-key (kbd "M-l") 'select-current-line)

;; ediff
;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

(add-hook 'ediff-before-setup-hook 'hiwin-deactivate)
(add-hook 'ediff-quit-hook 'hiwin-activate)

;; extend ediff
(defun ediff-two-window ()
  (interactive)
  (let ((buffer1 (buffer-file-name (car (buffer-list))))
        (buffer2 (buffer-file-name (cadr (buffer-list)))))
    (setq msg1 (format "#<%s>" buffer1))
    (setq msg-mid (format " "))
    (setq msg2 (format "#<%s>" buffer2))
    (setq msg (concat msg1 msg-mid msg2))
    (message "%s" msg)
    (ediff buffer1 buffer2)))

(global-set-key (kbd "C-c C-e") 'ediff-two-window)

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
(global-set-key (kbd "C-c C-p") 'get-current-path-to-clipboard)

(defun shell-command->string (cmd)
  (let ((r (shell-command-to-string cmd)))
    (substring-no-properties r 0 (1- (length r)))))

;; open URL with "command open"
(defun my-open-at-point ()
  "Ask /usr/bin/open to open the thing at or before point."
  (interactive)
  (require 'ffap)
  (let ((file (or (ffap-url-at-point)
                  (ffap-file-at-point))))
    (unless (stringp file)
      (error "No file or URL found"))
    (when (file-exists-p (expand-file-name file))
      (setq file (expand-file-name file)))
    (message "Open: %s" file)
    (start-process "open_ps" nil "open" file)))

(global-set-key (kbd "C-c C-o") 'my-open-at-point)
;; double click
(global-set-key [double-mouse-1] 'my-open-at-point)
(global-set-key [double-down-mouse-1] 'ignore) ; mouse-drag-region

(provide 'tools)
