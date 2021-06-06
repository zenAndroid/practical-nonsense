(<= 1 2 3 4 5 6 7 8 9) ; T
(<= 1 2 3 4 5 9 6 7 8 9) ; NIL

;; (max -1 2 -3) → 2
;; Some other handy functions are ZEROP, MINUSP, and PLUSP, which test whether a single 
;; real number is equal to, less than, or greater than zero. Two other predicates, EVENP and ODDP, 
;; test whether a single integer argument is even or odd. The P suffix on the names of these functions 
;; is a standard naming convention for predicate functions, functions that test some condition and return
;; a boolean


; Guess I'll do the next chapter too then
(make-array 5 :fill-pointer 0 :adjustable t)

(defvar hii (make-array 5 :fill-pointer 0 :adjustable t :element-type 'character))


(remove-duplicates '(1 1 1 1 2 23 3 4 5 31  3 2 34 49 0 9 8 8 9))

(defparameter *x* (vector 1 2 3))
(length *x*)
(elt *x* 0)
(elt *x* 1)
(elt *x* 2)
(elt *x* 3)
;; --
;; (1 23 4 5 31 3 2 34 49 0 8 9)
;; --
;; *X*
;; --
;; 3
;; --
;; 1
;; --
;; 2
;; --
;; 3
;; --
;; #<SB-KERNEL:INDEX-TOO-LARGE-ERROR expected-type: (INTEGER 0 2) datum: 3>
;; 

(setf (elt *x* 0) 10)

(subseq "abcdefghijklmnopqrstuvwxyz" 13)

(every #'evenp #(1 2 3 4 5))    
(some #'evenp #(1 2 3 4 5))     
(notany #'evenp #(1 3 5))   
(notevery #'evenp #(2 4)) 

(defparameter *h* (make-hash-table))

(gethash 'foo *h*)

(setf (gethash 'foo *h*) 'quux)
