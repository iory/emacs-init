;; cmake-mode
(require 'cmake-mode)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

;; C++ style
(defun add-c++-mode-conf ()
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0)
  (show-paren-mode t))
(add-hook 'c++-mode-hook 'add-c++-mode-conf)

;; C style
(defun add-c-mode-common-conf ()
  (c-set-style "stroustrup")
  (show-paren-mode t)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0))
(add-hook 'c-mode-common-hook 'add-c-mode-common-conf)
