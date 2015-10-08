;;; clipboard.el --- clipborad-settings

;; Copyright (C) 2015  iori

;; Author: iori <ab.ioryz@gmail.com>

(cond
 ;; mac OSX
 ((string-match "apple-darwin" system-configuration)
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  )
 ;; linux (ubuntu)
 ((string-match "linux" system-configuration)
  ;;
  )
 (t
  )
 )

(provide 'clipboard-setting)
