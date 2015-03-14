;; commands history
(setq desktop-globals-to-save '(extended-command-history))
(setq desktop-files-not-to-save "")
(desktop-save-mode 1)
(put 'upcase-region 'disabled nil)


;; 前景色を黒，背景色を赤にする．
(custom-set-faces
 '(linum-highlight-face ((t (:foreground "black"
                             :background "red")))))


;; cmake-mode
(require 'cmake-mode)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))


(setq-default c-basic-offset 4     ;;基本インデント量4
              tab-width 4          ;;タブ幅4
               indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか

;; C++ style
(defun add-c++-mode-conf ()
  (c-set-style "stroustrup")  ;;スタイルはストラウストラップ
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
  (show-paren-mode t))        ;;カッコを強調表示する
(add-hook 'c++-mode-hook 'add-c++-mode-conf)

;; C style
(defun add-c-mode-common-conf ()
  (c-set-style "stroustrup")                  ;;スタイルはストラウストラップ
  (show-paren-mode t)                         ;;カッコを強調表示する
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
  )
(add-hook 'c-mode-common-hook 'add-c-mode-common-conf)
