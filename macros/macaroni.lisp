;; (+ 1 1)

;; (mapcar #'string-upcase (list "hello" "world"))

;; (dolist (x '(1 2 3)) (print x))
;;;   (dolist (x '(1 2 3)) (print x))
;;;
;;;   1
;;;   2
;;;   3
;;;   NIL
;;;   CL-USER >


;; (dolist (x '(1 2 3)) (print x) (if (evenp x) (return)))
;;  1
;;  2

;; (dotimes (i 10) (print i))

;; (dotimes (i 20)
;;   (dotimes (j 20)
;;     (format t "~dx~d=~3d~%" (+ 1 i) (+ 1 j) (* (+ 1 i) (+ 1 j)))))

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


;; (loop for i from 1 to 20 collecting i)

;; (defun foob (strong)
;;   "Counts the vowels in the argument string uwu"
;;   (loop for x across strong
;;         counting (find x "aeoui")))


;; (foob "zenAndroid is enjoying this book, but damn does he find this CL thing ugly ...")

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


;; Chapter 8 starts here ! 

;; (defmacro macro-name (parameters*)
;;   "Optional doc-string"
;;   body-form*)

;; (defun primep (number)
;;   (when (> number 1)
;;     (loop for i from 2 to (isqrt number) never (zerop (mod number i)))))

;; It is a prime predicate

;; (defun next-prime (number)
;;   (loop for n from number when (primep n) return n))

;; (defmacro do-primes ((var start end) &body body)
;;   `(do ((,var (next-prime ,start) (next-prime (+ 1 ,var))))
;;        ((> ,var ,end)) ; This condition is tested, and when it is true, the looping stops
;;      ,@body))


;; (do-primes (p 98 542)
;;   (format t "~d " p))

;; I will actually just continue doing the ninth hapter here

(defun report-result (result form)
  "doc"
  (format t "~:[FAIL~;pass~] ... ~a :: ~a~%" result *test-name* form)
  result)

;; (defmacro check (&body forms)
;;   `(progn
;;      ,@(loop for f in forms collect `(report-results ,f ',f))))


;; (with-gen ;; oh god am i going to need to redefine this on my own?
;;   You'd think that it is available in the standard though? weird

(defmacro with-gensyms ((&rest names) &body body) ;; Here it is
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
      ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

;; (defun test-+ ()
;;   "Testing the addition function that is built-in to CL"
;;   (let ((*test-name* 'test-+))
;;     (check (= (+ 1 2) 3)
;;       (= (+ 23 23) 46)
;;       (= (+ 45 32) 77))))
;; (COMBINE-RESULTS
;;   (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3))
;;   (REPORT-RESULT (= (+ 23 23) 46) '(= (+ 23 23) 46))
;;   (REPORT-RESULT (= (+ 45 32) 77) '(= (+ 45 32) 77)))
;; This is what that atrocity expands into ...
;; ... yeah 
;; (LET ((#:G639 T))
;;   (IF (REPORT-RESULT (= (+ 1 2) 3) '(= (+ 1 2) 3))
;;       NIL
;;       (SETQ #:G639 NIL))
;;   (IF (REPORT-RESULT (= (+ 23 23) 46) '(= (+ 23 23) 46))
;;       NIL
;;       (SETQ #:G639 NIL))
;;   (IF (REPORT-RESULT (= (+ 45 32) 77) '(= (+ 45 32) 77))
;;       NIL
;;       (SETQ #:G639 NIL))
;;   #:G639)
;; (test-+)
;; pass ... (= (+ 1 2) 3)
;; pass ... (= (+ 23 23) 46)
;; pass ... (= (+ 45 32) 77)
;; T
;; CL-USER>

; (test-+)

;; Make DAMN sure you ankify this stuff


;; -------------- How thw fuck is the combine results in the next section working ?????

;; (defun test-* ()
;;   (let ((*test-name* 'test-*))
;;     (check
;;       (= (* 2 2) 4)
;;       (= (* 3 5) 15))))

(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))

(test-arithmetic)


;; (LET ((#:G639 T))
;;   (UNLESS (TEST-+) (SETF #:G639 NIL))
;;   (UNLESS (TEST-*) (SETF #:G639 NIL))
;;   #:G639)

;; Question : HOW THE FUCK DOES THAT WORK ?
;; guess ill macro expand and try to understand
;; *after macro-expansion*: Hmm, okay i think i had a mistaken understanding of the working of the thing ...

(defvar *test-name* nil)


(defmacro deftest (name parameters &body body)
  "Define a test function. Within a test function we can call
   other test functions or use 'check' to run individual test
   cases"
  `(defun ,name ,parameters
     ;; (let ((*test-name* ',name))
     (let ((*test-name* (append *test-name* (list ',name)))) ; Why ? explain
      ,@body)))

(deftest test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))
(deftest test-* ()
  (check
    (= (* 1 2) 2)
    (= (* 1 2 3) 6)
    (= (* -1 -3) 3)))





