;;; insert-setting.el --- template

;; Copyright (C) 2015  iori

;; Author: iori

(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "\\.cpp$" "c-plusplus-template.cpp")
(define-auto-insert "\\.c$" "c-template.c")
(define-auto-insert "\\.py$" "py-template.py")
(define-auto-insert "\\.launch$" "launch-template.launch")

(provide 'insert-setting)
