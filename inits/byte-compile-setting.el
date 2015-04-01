;;; byte-compile-setting.el --- auto-async-byte-compile-setting  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  iori

;; Author: iori

(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(provide 'byte-compile-setting)
