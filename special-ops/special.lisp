(labels ((foobar (b) (format nil "~a" b)) 
         (second-func (a b) (* a b))
         (third-foo (b) (if (= b 0) (foobar "boop") (second-func 55 2))))
  (third-foo 4))  ; 45

(block balook
  (format t "~a~%" 'kke)
  (return-from balook '(bepis))
  (format t "~a" 'kek))
  
(tagbody
 a (print 'a) (if (zerop (random 2)) (go c))
 b (print 'b) (if (zerop (random 2)) (go a))
 c (print 'c) (if (zerop (random 2)) (go b)))

(funcall #'+ (values 1 2 3 4 5 6 7 8 9));)

