;;; tools.el --- my elisp function tools

;; Copyright (C) 2015  iori

;; Author: iori
;; Keywords: elisp

(defun copy-current-line ()
  (interactive)
  (let (start
        end
        (current-pos (point))
        (old-kill-ring (car kill-ring)))
    (cond (mark-active
           (setq start (region-beginning)
                 end   (region-end)))
          (t
           (beginning-of-line)
           (setq start (point))
           (end-of-line)
           (setq end (point))))
    (kill-ring-save start end)
    (if (equal old-kill-ring (car kill-ring))
        (progn
          (end-of-line)
          (open-line 1)
          (forward-line)
          (yank)
          (goto-char current-pos)
          (forward-line))
      (goto-char current-pos))
    ))

(defun select-current-line ()
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))


(global-set-key (kbd "M-p") 'copy-current-line)
(global-set-key (kbd "M-l") 'select-current-line)

(provide 'tools)
