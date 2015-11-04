;;; euslisp.el --- euslisp extention

;; Copyright (C) 2015  iori

;; Author: iory

(require 'tools)

(defun get-lisp-function-path (fname)
  (let ((paths
         (shell-command->string
          (concatenate #'string "python ~/.emacs.d/bin/find_lispfunction.py " fname)))
      )
    (split-string paths " ")
    )
  )

(defun goto-euslisp-function-implementation (fname)
  (helm-build-sync-source "goto-euslisp"
    :candidates (get-lisp-function-path fname)
    :action '(lambda (x)
               (let ((xlst (split-string x "\\*\\*\\*")))
                 (find-file (car xlst))
                 (goto-line (1+ (string-to-number (cadr xlst))))
                 ))
    :migemo t))

(defun goto-euslisp-function (fname)
  (interactive)
  (helm :sources (goto-euslisp-function-implementation fname) :buffer "*helm-euslisp*"))

(defun find-euslisp-function ()
  (interactive)
  (if (and transient-mark-mode mark-active)
      (goto-euslisp-function (buffer-substring (region-beginning) (region-end)))
    (goto-euslisp-function (print-current-word))
      )
  )

(defun print-current-word ()
  "print current word."
  (interactive)
  (let (p1 p2)
    (save-excursion
      (skip-chars-backward "-a-z0-9")
      (setq p1 (point))
      (skip-chars-forward "-a-z0-9")
      (setq p2 (point))
      (message "%s" (buffer-substring-no-properties p1 p2)))))

(define-key lisp-mode-map "\C-c." 'find-euslisp-function)

(provide 'euslisp)
