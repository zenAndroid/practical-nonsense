(+ 1 1)

(with-open-file (fDesc "/home/zenandroid/fii.txt" :if-exists :supersede :direction :output)
  (format fDesc "Heeeeeeey"))

(defparameter paname (make-pathname :directory '(:absolute "foo" "bar") :name "help"))

(print *DEFAULT-PATHNAME-DEFAULTS*)

(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

(defun directory-pathname-p  (p);{{{
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p));}}}

(defun pathname-as-directory (name);{{{
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (not (directory-pathname-p name))
      (make-pathname
       :directory (append (or (pathname-directory pathname) (list :relative))
                          (list (file-namestring pathname)))
       :name      nil
       :type      nil
       :defaults pathname)
      pathname)));}}}

(defun directory-wildcard (dirname);{{{ This basically calls pathname-as-directory, then patches it to conform to CLISP 
  ; I suppose a more accurate retelling is that it creates a pathname that defaults to the value returned by 
  ; pathname-as-directory, then monkey-patches the type to conform to CLISP. (idont think im using that word the way its supposed to be used)
  (make-pathname
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defaults (pathname-as-directory dirname)));}}}

(merge-pathnames #p"foo/bar.html" #p"/www/html/")

;; It finally clicking, ... nothing better than pen and paper when the confusion strikes ...

paname ; #P"/foo/bar/help"

(pathname-as-directory paname) ; This helps me understand what is going on this results in #P"/foo/bar/help/"

(directory-pathname-p paname) ; This helps me understand what is going on this results in NIL 
                              ; (paname's name string is not finished by a slash, and is in file form)
(append 
  (or (pathname-directory paname) (list :relative)) ; If the pathname has a directory, it is the result of the OR
                                                    ; expression, else if it doesnt then the result of the OR 
                                                    ; expression is the list '(:relative), in this case we get 
                                                    ; (:ABSOLUTE "foo" "bar") so that is the result
  (list (file-namestring paname))) ; results in 'help', and that then gets appended to (:ABSOLUTE "foo" "bar")
                                   ; to yield (:ABSOLUTE "foo" "bar" "help"), this is then the final directory
