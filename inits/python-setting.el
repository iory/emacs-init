;===============
; jedi
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(define-key jedi-mode-map (kbd "<C-tab>") nil)

(defun tnoda/turn-on-flycheck-mode ()
  (flycheck-mode 1))
(add-hook 'python-mode-hook 'tnoda/turn-on-flycheck-mode)
;; flychek
(add-hook 'python-mode-hook 'flycheck-mode)

(eval-after-load 'flycheck
  '(progn
     (flycheck-add-mode 'python-pylint 'yapm-mode)
     (flycheck-add-mode 'python-flake8 'yapm-mode)))
