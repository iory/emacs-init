;; ;; グループ化せずに*scratch*以外のタブを表示
;; (require 'cl)
;;  (when (require 'tabbar nil t)
;;     (setq tabbar-buffer-groups-function
;; 	    (lambda (b) (list "All Buffers")))
;;     (setq tabbar-buffer-list-function
;;           (lambda ()
;;             (remove-if
;;              (lambda(buffer)
;; 	       (unless (string= (buffer-name buffer) "*shell*")
;; 		 (find (aref (buffer-name buffer) 0) " *")))
;;              (buffer-list))))
;;     (tabbar-mode))

;; ;; 左に表示されるボタンを無効化
;; (setq tabbar-home-button-enabled "")
;; (setq tabbar-scroll-left-button-enabled "")
;; (setq tabbar-scroll-right-button-enabled "")
;; (setq tabbar-scroll-left-button-disabled "")
;; (setq tabbar-scroll-right-button-disabled "")

;; ;; 色設定
;;  (set-face-attribute
;;    'tabbar-default-face nil
;;    :background "gray90") ;バー自体の色
;;   (set-face-attribute ;非アクティブなタブ
;;    'tabbar-unselected-face nil
;;    :background "gray90"
;;    :foreground "black"
;;    :box nil)
;;   (set-face-attribute ;アクティブなタブ
;;    'tabbar-selected-face nil
;;    :background "black"
;;    :foreground "white"
;;    :box nil)

;; ;; 幅設定
;;   (set-face-attribute
;;    'tabbar-separator-face nil
;;    :height 0.7)

;; ;; Firefoxライクなキーバインドに
;; ;; (global-set-key [(control tab)]       'tabbar-forward)
;; ;; (global-set-key [(control shift iso-lefttab)] 'tabbar-backward)
;; ;; (global-set-key (kbd "C-<tab>") 'tabbar-forward-tab)
;; (global-set-key [(C-tab)] 'tabbar-forward-tab)
;; (global-set-key [(C-S-tab)] 'tabbar-backward-tab)

;; ;; -nw では効かないので別のキーバインドを割り当てる
;; (global-set-key (kbd "C-x n") 'tabbar-forward)
;; (global-set-key (kbd "C-x p") 'tabbar-backward)

;; ;;F4ボタンで切り替え
;; (global-set-key [f4] 'tabbar-mode)


;; ------------------------------------------------------------------------
;; @ tabbar.el

;; タブ化
;; http://www.emacswiki.org/emacs/tabbar.el
;;(require 'cl)
(require 'tabbar nil t)

(setq tabbar-buffer-groups-function
      (lambda (b) (list "All Buffers")))

(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda(buffer)
           (unless (string-match (buffer-name buffer)
                                 "\\(*scratch*\\|*Apropos*\\|*shell*\\|*eshell*\\|*Customize*\\)")
             (find (aref (buffer-name buffer) 0) " *"))
           )
         (buffer-list))))

;; tabbarを有効にする
(tabbar-mode 1)

;; ボタンをシンプルにする
(setq tabbar-home-button-enabled "")
(setq tabbar-scroll-right-button-enabled "")
(setq tabbar-scroll-left-button-enabled "")
(setq tabbar-scroll-right-button-disabled "")
(setq tabbar-scroll-left-button-disabled "")

;; Ctrl-Tab, Ctrl-Shift-Tab でタブを切り替える
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
         ,on-no-prefix
       ,on-prefix)))
(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)
(global-set-key [(control shift iso-lefttab)] 'shk-tabbar-prev)

;; GUIで直接ファイルを開いた場合フレームを作成しない
(add-hook 'before-make-frame-hook
          (lambda ()
            (when (eq tabbar-mode t)
              (switch-to-buffer (buffer-name))
              (delete-this-frame))))


(global-set-key (kbd "s-w") 'kill-this-buffer)

(provide 'tab-setting)
