;===============
; jedi
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;; (setq python-shell-interpreter "/usr/local/bin/ipython")
;; (require 'ipython)

(setenv "PYTHONPATH" (exec-path-from-shell-copy-env "PYTHONPATH"))
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(define-key jedi-mode-map (kbd "<C-tab>") nil)

(eval-after-load "python"
  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)

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

(setq auto-mode-alist (cons '("\\.pyx\\'" . python-mode) auto-mode-alist))

(provide 'python-setting)
