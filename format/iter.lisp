(format nil "~{~a, ~}" (list 1 2 3 4))
(format nil "~{~a~^, ~}." (list 1 2 3 4))

(format nil "~{~s~*~^ ~}" '(:a 10 :b 20 :c 343434))
(format nil "~{~s~*~^ ~}" '(:a 10 :b 20))
