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

;; (defun tnoda/turn-on-flycheck-mode ()
;;   (flycheck-mode 1))
;; (add-hook 'python-mode-hook 'tnoda/turn-on-flycheck-mode)
;; ;; flychek
;; (add-hook 'python-mode-hook 'flycheck-mode)

;; (eval-after-load 'flycheck
;;   '(progn
;;      (flycheck-add-mode 'python-pylint 'yapm-mode)
;;      (flycheck-add-mode 'python-flake8 'yapm-mode)))

(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list (shell-command->string "which pyflakes") (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
; show message on mini-buffer
(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)

(provide 'python-setting)
