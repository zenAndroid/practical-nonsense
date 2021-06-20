(loop for x across "abcd" collect x)

(loop repeat 5 
      for x = 0 then y
      for y = 1 then (+ x y)
      collect y)

(defparameter *random* (loop repeat 100 collect (random 10000)))

(loop for i in (loop repeat 1000 collect (random 10000))
   counting (evenp i) into evens
   counting (oddp i) into odds
   summing i into total
   maximizing i into max
   minimizing i into min
   finally (return (list min max total evens odds)))

; This is pretty goddamn elegant ... :thinking:
