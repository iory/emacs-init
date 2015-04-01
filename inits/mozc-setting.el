;; language-setting
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)
(define-key global-map (kbd "C-\\") 'mozc-mode)

(provide 'mozc-setting)
