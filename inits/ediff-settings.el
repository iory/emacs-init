;;; ediff-settings.el --- extend ediff settings

;; Copyright (C) 2015  iori

;; Author: iori

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(add-hook 'ediff-before-setup-hook 'hiwin-deactivate)
(add-hook 'ediff-quit-hook 'hiwin-activate)

;; extend ediff
(defun ediff-two-window ()
  (interactive)
  (let ((wlist (window-list)))
    (unless (= 2 (length wlist))
      (error "window must be divided two windows!"))
    (ediff-buffers (window-buffer (car wlist))
                   (window-buffer (cadr wlist)))))

(global-set-key (kbd "C-c e") 'ediff-two-window)

(provide 'ediff-setting)
