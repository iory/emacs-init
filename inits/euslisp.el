;;; euslisp.el --- euslisp extention

;; Copyright (C) 2015  iori

;; Author: iory

(require 'tools)



(defun load-grep ()
  (let ((loads nil)
        (current-point (point)))
    (goto-char 0) ;;バッファの先頭に移動
    ;; (count-lines START END) START 位置から END のポイントまでの行数を数える
    (loop for i from 1 to (count-lines (point-min) (point-max)) do
          (cond ((string-match-p "(load " (buffer-substring-no-properties (point-at-bol) (point-at-eol)))
                 (push (buffer-substring-no-properties (point-at-bol) (point-at-eol)) loads)
                 )
                ((string-match-p "(require " (buffer-substring-no-properties (point-at-bol) (point-at-eol)))
                 (push (buffer-substring-no-properties (point-at-bol) (point-at-eol)) loads)
                 )
                (t
                 )
                )
          (forward-line 1))
    (goto-char current-point)
    loads)
  )

(defun load-buffers (texts)
  (let (text
        start
        end
        loaded-file-name
        (paths "")
        )
    (loop for i from 0 to (1- (length texts)) do
          (setq text (elt texts i))
          (if (string-match "(load" text)
              (setq start (+ (length "(load") (string-match "(load" text)))
            ;; else
            (setq start (+ (length "(require") (string-match "(require" text)))
            )
          (setq end (1+ (string-match ")" text start)))
          (setq loaded-file-name (substring text start end))
          (if (string-match-p "package:\\/\\/" loaded-file-name)
            (let (package-name-start
                  package-name-end
                  file-path
                  )
              (setq package-name-start (+ (string-match "package:\\/\\/" loaded-file-name) (length "package://")))
              (setq package-name-end (string-match "\\/" loaded-file-name package-name-start))
              (setq file-path (shell-command->string (concatenate #'string "rospack find " (substring loaded-file-name package-name-start package-name-end))))
              (when (file-exists-p file-path)
                (setq paths (concatenate #'string paths file-path " "))
                )
              )
            ;; else
            (progn
              (when (string-match "\\.l" loaded-file-name)
                (setq file-path (substring loaded-file-name (+ (length " \"") (string-match " \"" loaded-file-name)) (string-match "\\.l" loaded-file-name)))
                (setq file-path (concatenate #'string (substring (buffer-file-name) 0 (- (length (buffer-file-name)) (length (file-name-nondirectory (buffer-file-name)))))))
                (setq file-path (substring file-path 0 (1- (length file-path))))
                (when (file-directory-p file-path)
                  (setq paths (concatenate #'string paths file-path " "))
                  )
                )
              )
            )
          )
    paths)
  )


(defun get-lisp-function-path (fname)
  (let (paths
        (load-paths (load-buffers (load-grep))))
    (if load-paths
        (setq paths
              (shell-command->string
               (concatenate #'string "python ~/.emacs.d/bin/find_lispfunction.py " fname " " load-paths)))
      (setq paths
            (shell-command->string
             (concatenate #'string "python ~/.emacs.d/bin/find_lispfunction.py " fname " ")))
      )
    (split-string paths "\\*\\*\\*\\*")
    )
  )


(defun goto-euslisp-function-implementation (fname)
  (helm-build-sync-source "goto-euslisp"
    :candidates (get-lisp-function-path fname)
    :action '(lambda (x)
               (let ((xlst (split-string x "\\*\\*\\*")))
                 (find-file (car xlst))
                 (goto-line (1+ (string-to-number (cadr xlst))))
                 (forward-char (string-match fname (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
                 ))
    :migemo t))

(defun goto-euslisp-function (fname)
  (interactive)
  (helm :sources (goto-euslisp-function-implementation fname) :buffer "*helm-euslisp*"))

(defun find-euslisp-function ()
  (interactive)
  (load "~/.emacs.d/shellenv.el")
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
