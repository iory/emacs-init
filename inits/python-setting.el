;===============
; jedi (package.elの設定より下に書く)
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
;;(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
;;(setenv "PYTHONPATH" "/usr/local/lib/python3.4/site-packages")
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
