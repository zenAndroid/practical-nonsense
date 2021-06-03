(+ 1 1)

(first (list #'(lambda() 1)))

(third 
  (let ((count 0))
    (list
      #'(lambda () (incf count))
      #'(lambda () (decf count))
      #'(lambda () count)))) ; => Still dont know how to invoke these ...

(defvar *x* 10)
(defun foo () (format t "X: ~d~%" *x*))

(foo)

;;; CL-USER(4): (defun foo () (format t "X: ~d~%" *x*))
;;; 
;;; FOO
;;; CL-USER(5): (foo)
;;; X: 10
;;; NIL
;;; CL-USER(6): (let ((*x* 20)) (foo))
;;; X: 20
;;; NIL
;;; CL-USER(7): (foo)
;;; X: 10
;;; NIL
;;; CL-USER(8):

(defun bar ()
  (foo)
  (let ((*x* 20)) (foo))
  (foo))

(bar)

;;; CL-USER(13): (defun bar ()
;;;                (foo)
;;;                (let ((*x* 20)) (foo))
;;;                (foo))
;;; WARNING: redefining COMMON-LISP-USER::BAR in DEFUN
;;; 
;;; BAR
;;; CL-USER(14): (bar)
;;; X: 10
;;; X: 20
;;; X: 10
;;; NIL
;;; CL-USER(15)
