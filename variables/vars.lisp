(+ 1 1)

(car (list #'(lambda() 1)))

(third 
  (let ((count 0))
    (list
      #'(lambda () (incf count))
      #'(lambda () (decf count))
      #'(lambda () count)))) ; => Still dont know how to invoke these ...
