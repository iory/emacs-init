;; quick-run setting
(require 'quickrun)

(push '("*quickrun*") popwin:special-display-config)
(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "C-'") 'quickrun)

;; Add C++ command for C11 and set it default in C++ file.
(quickrun-add-command "c++/clang++"
                      '((:command . "g++")
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

;; (quickrun-add-command "roseus"
;;                       '((:command . "roseus")
;;                         (:exec . ("%c %s")))
;;                       :default "roseus")

;;(quickrun-set-default "python" "python3")
(quickrun-set-default "lisp" "commonlisp")

(provide 'quickrun-setting)
