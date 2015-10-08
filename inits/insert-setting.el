;;; insert-setting.el --- template

;; Copyright (C) 2015  iori

;; Author: iori

(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "CMakeLists.txt" "cmake-template.txt")
(define-auto-insert "\\.c$" "c-template.c")
(define-auto-insert "\\.cpp$" "c-plusplus-template.cpp")
(define-auto-insert "\\.l$" "euslisp-template.l")
(define-auto-insert "\\.launch$" "launch-template.launch")
(define-auto-insert "\\.py$" "py-template.py")
(define-auto-insert "\\.sh$" "sh-template.sh")

(provide 'insert-setting)
