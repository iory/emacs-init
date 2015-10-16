;;; markdown setting

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun markdown-render (n)
  (interactive "p")
  (message (buffer-file-name))
  (message (concatenate 'string "grip " (buffer-file-name)))
  (shell-command (concatenate 'string "grip " (buffer-file-name) " &"))
  )

(provide 'markdown-setting)
