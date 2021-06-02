(defun func-name (arg-1 arg-2)
  "Optional docstring?"
  (+ arg-2 arg-1))

(func-name 2 9)

(defun func-name2 (a b &optional c &key d)
  (format t "~d ~d ~d ~d ~%" a b c d)) ;=> Dont do this, dont mix optional with key argument willy nilly like this.
; => Go to the book to remember why, but i reckon it should be obvious

(func-name2 1 2)
(func-name2 1 2 3)
(func-name2 1 2 :d "doot")
