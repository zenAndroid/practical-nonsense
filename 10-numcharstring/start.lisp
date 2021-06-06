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
