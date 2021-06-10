(+ 1 1)

(with-open-file (fDesc "/home/zenandroid/fii.txt" :if-exists :supersede :direction :output)
  (format fDesc "Heeeeeeey"))

(make-pathname :directory '(:absolute "foo" "bar") :name "help" :type "txt")

(print *DEFAULT-PATHNAME-DEFAULTS*)

(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

(defun directory-pathname-p  (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))

(defun pathname-as-directory (name)
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
      pathname)))

(defun directory-wildcard (dirname)
  (make-pathname
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defaults (pathname-as-directory dirname)))

;; Gotta be honest mang, this stuff isnt getting in the noggin too much ...
;; Too abstract and shit

(merge-pathnames #p"foo/bar.html" #p"/www/html/")

;; It finally clicking, ... nothing better than pen and paper when the confusion strikes ...
