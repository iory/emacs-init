;;; windows-setting.el --- for windows               -*- lexical-binding: t; -*-

;; Copyright (C) 2015

;; Author:  iori
;; Keywords: windows emacs

(set-default-coding-systems 'utf-8-dos)
(setq default-file-name-coding-system 'shift_jis)

(defconst FONT_FAMILY "Ricty Diminished Discord")
(defconst FONT_SIZE 12)
(set-frame-font (concat FONT_FAMILY "-" (format "%s" FONT_SIZE)))

(add-hook
 'shell-mode-hook
 '(lambda ()
    (set-buffer-process-coding-system 'sjis 'sjis)))

(provide 'windows-setting)
