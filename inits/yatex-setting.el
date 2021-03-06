;;; yatex-setting.el --- yatex's setting

;; Copyright (C) 2015  iori

;; Author: iori <iori@iori-ThinkPad-T440p>
;; Keywords:

(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq tex-command "platex2pdf")
(cond
  ((eq system-type 'gnu/linux)
    (setq dvi2-command "evince"))
  ((eq system-type 'darwi ;; if you use mac system, open file by preview.
    (setq dvi2-command "open -a Preview")))
(add-hook 'yatex-mode-hook '(lambda () (setq auto-fill-function nil)))

;; set YaTeX coding system
(setq YaTeX-kanji-code 4)

(provide 'yatex-setting)
