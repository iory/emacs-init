;;; c-setting.el --- flycheck auto-complete                -*- lexical-binding: t; -*-

;; Copyright (C) 2015  iori

;; Author: iori
;; Keywords:

;; detect header file for c++

(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-hook 'c-mode-common-hook 'flycheck-mode)

(defmacro flycheck-define-clike-checker (name command modes)
  `(flycheck-define-checker ,(intern (format "%s" name))
     ,(format "A %s checker using %s" name (car command))
     :command (,@command source-inplace)
     :error-patterns
     ((warning line-start (file-name) ":" line ":" column ": warning:" (message) line-end)
      (error line-start (file-name) ":" line ":" column ": error:" (message) line-end))
     :modes ',modes))
(flycheck-define-clike-checker c-gcc-ja
                               ("gcc" "-fsyntax-only" "-Wall" "-Wextra")
                               c-mode)
(add-to-list 'flycheck-checkers 'c-gcc-ja)
(flycheck-define-clike-checker c++-g++-ja
                               ("g++" "-fsyntax-only" "-Wall" "-Wextra" "-std=c++11")
                               c++-mode)
(add-to-list 'flycheck-checkers 'c++-g++-ja)

;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             ))

(provide 'c-setting)
