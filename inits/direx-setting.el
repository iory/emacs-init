;; popwin
(require 'popwin)
;; (setq special-display-function 'popwin:special-display-popup-window)
(setq display-buffer-function 'popwin:display-buffer)

(require 'dired)
(define-key dired-mode-map (kbd "g") 'dired-k)
(add-hook 'dired-initial-position-hook 'dired-k)

;;; coloring to git
(require 'direx-k)
(global-set-key (kbd "C-c C-;") 'direx-project:jump-to-project-root-other-window)
(define-key direx:direx-mode-map (kbd "K") 'direx-k)

;; direx
(require 'direx)
(require 'direx-project)

(defun my/dired-jump ()
  (interactive)
  (cond (current-prefix-arg
         (dired-jump))
        ((not (one-window-p))
         (or (ignore-errors
               (direx-project:jump-to-project-root) t)
             (direx:jump-to-directory)))
        (t
         (or (ignore-errors
               (direx-project:jump-to-project-root-other-window) t)
             (direx:jump-to-directory-other-window)))))

(global-set-key (kbd "C-x C-j") 'my/dired-jump)

;; (setq direx:leaf-icon "  "
;;       direx:open-icon "▾ "
;;       direx:closed-icon "▸ ")

(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)

(provide 'direx-setting)
