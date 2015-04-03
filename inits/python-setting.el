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

(require 'flymake)

;; for whole language
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; I use flymake only python.
(add-hook 'python-mode-hook '(lambda () (flymake-mode t)))

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
