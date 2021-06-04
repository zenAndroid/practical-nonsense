(+ 1 1)

(mapcar #'string-upcase (list "hello" "world"))

(dolist (x '(1 2 3)) (print x))
;;;   (dolist (x '(1 2 3)) (print x))
;;;
;;;   1
;;;   2
;;;   3
;;;   NIL
;;;   CL-USER >


(dolist (x '(1 2 3)) (print x) (if (evenp x) (return)))
;;  1
;;  2

(dotimes (i 10) (print i))

(dotimes (i 20)
  (dotimes (j 20)
    (format t "~dx~d=~3d~%" (+ 1 i) (+ 1 j) (* (+ 1 i) (+ 1 j)))))

;; Output is as expected
;; 19x8=152
;; 19x9=171
;; 19x10=190
;; 19x11=209
;; 19x12=228
;; 19x13=247
;; 19x14=266
;; 19x15=285
;; 19x16=304
;; 19x17=323
;; 19x18=342
;; 19x19=361
;; 19x20=380
;; 20x1= 20
;; 20x2= 40
;; 20x3= 60
;; 20x4= 80
;; 20x5=100
;; 20x6=120
;; 20x7=140
;; 20x8=160
;; 20x9=180
;; 20x10=200
;; 20x11=220
;; 20x12=240
;; 20x13=260
;; 20x14=280
;; 20x15=300
;; 20x16=320
;; 20x17=340
;; 20x18=360
;; 20x19=380
;; 20x20=400

(do ((n 0 (1+ n))
     (cur 0 next)
     (next 1 (+ cur next)))
    ((= 10 n) cur))

;;; Output\[ 
;;; (do ((n 0 (1+ n))
;;;      (cur 0 next)
;;;      (next 1 (+ cur next)))
;;;     ((= 10 n) cur))]
;;; 55


(loop for i from 1 to 20 collecting i)

(defun foob (strong)
  "Counts the vowels in the argument string uwu"
  (loop for x across strong
        counting (find x "aeoui")))


(foob "zenAndroid is enjoying this book, but damn does he find this CL thing ugly ...")

;; Returns 19 ...

(loop for i below 10
      and a = 0 then b
      and b = 1 then (+ b a)
      finally (return a))

;; (loop for i below 10
;;       and a = 0 then b
;;       and b = 1 then (+ b a)
;;       finally (return a))
;; 55


Chapter 8 starts here ! 

;; (defmacro macro-name (parameters*)
;;   "Optional doc-string"
;;   body-form*)

(defun primep (number)
  (when (> number 1)
    (loop for i from 2 to (isqrt number) never (zerop (mod number i)))))

;; It is a prime predicate

(defun next-prime (number)
  (loop for n from number when (primep n) return n))
