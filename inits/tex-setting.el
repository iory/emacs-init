;;; tex-setting.el --- for tex

;; Copyright (C) 2015  iori

;; Author: iori
;; Keywords: tex, emacs, yatex

;; .tex as yatex-mode
(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq tex-command "platex2pdf")
(cond
  ((eq system-type 'gnu/linux) ;; Ubuntu
    (setq dvi2-command "evince")) ;; see PDF with evince
  ((eq system-type 'darwin) ;; MAC
    (setq dvi2-command "open -a Preview"))) ;; see PDF with Preview
(add-hook 'yatex-mode-hook '(lambda () (setq auto-fill-function nil)))

;; insert date
(defun insert-date ()
  (interactive)
  (insert (concat "" (format-time-string "%Y-%m-%d"))))


(provide 'tex-setting)
