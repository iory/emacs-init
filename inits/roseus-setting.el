;;; roseus-setting.el --- roseus settings

;; Copyright (C) 2015  iori

;; Author: iori
;; Keywords: roseus euslisp emacs auto-complete

;; user dictionary
(defvar ac-user-dict-dir (expand-file-name "~/.emacs.d/ac-user-dict/"))

(defun ac-go-into-braces-action ()
  (save-restriction
    (narrow-to-region (point) (- (point) 2))
    (if (re-search-backward "()" nil t)
        (forward-char))))

;; menu's color
(defface ac-my-selection-face
  '((t (:background "#000080" :foreground "#ffffff")))
  "Face for selectied candidates."
  :group 'auto-complete)

;;; dictionary 1
(defface ac-underscore-roseus-candidate-face
  '((t (:background "#730CE8" :foreground "#eeeeee")))
  "Face for underscore.roseus candidates."
  :group 'auto-complete)
;; assign dictionary
(defvar ac-underscore-roseus-cache
  (ac-file-dictionary (concat ac-user-dict-dir "roseus_completions")))
(defvar ac-source-underscore-roseus-dict
  '((candidates . ac-underscore-roseus-cache) ;; candidate of source
    (candidate-face . ac-underscore-roseus-candidate-face) ;; color settings
    (selection-face . ac-my-selection-face) ;; selected color
    (action . ac-go-into-braces-action) ;; after completion
    (symbol . "roseus_completions")
    ;; (requires . 2) ;;
    ;; (limit . 30) ;;
    ))

(defun ac-roseus-mode-setup ()
  (setq ac-sources
        (append ac-sources
                '(
                  ac-source-abbrev
                  ac-source-words-in-same-mode-buffers
                  ac-source-yasnippet
                  ac-source-filename
                  ac-source-underscore-roseus-dict
                  ))))

 (add-hook 'lisp-mode-hook 'ac-roseus-mode-setup)
(setq ac-disable-faces '(font-lock-comment-face font-lock-doc-face))

(provide 'roseus-setting)
