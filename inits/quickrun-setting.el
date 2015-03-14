(require 'quickrun)

;; 邨先棡縺ｮ蜃ｺ蜉帙ワ繧吶ャ繝輔ぃ縺ｨ蜈��������繝上ｙ繝����ヵ繧｡繧定｡後″譚･縺励◆縺�����ｴ蜷医����
;; ':stick t'縺ｮ險ｭ螳壹ｒ縺吶ｋ縺ｨ繧医＞縺ｦ繧吶＠繧����≧
(push '("*quickrun*") popwin:special-display-config)

;; 繧医￥菴ｿ縺����↑繧峨く繝ｼ繧貞牡繧雁ｽ薙※繧九→繧医＞縺ｦ繧吶＠繧����≧
(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "C-'") 'quickrun)


;; Add C++ command for C11 and set it default in C++ file.
(quickrun-add-command "c++/clang++"
                      '((:command . "clang++")
                        (:exec . ("%c -std=c++11 -lstdc++ %o -o %e %s"
                                     "%e %a"))
                        (:remove . ("%e")))
                      :default "c++")

(quickrun-set-default "c++" "c++/clang++")

;; (quickrun-add-command "python3"
;;                       '((:command . "python3")
;;                         (:exec . ("%c %s")))
;;                       :default "python3")

(quickrun-add-command "commonlisp"
                      '((:command . "clisp")
                        (:exec . ("%c %s")))
                      :default "commonlisp")

;;(quickrun-set-default "python" "python3")
(quickrun-set-default "lisp" "commonlisp")
