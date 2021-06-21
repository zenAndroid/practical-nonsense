(in-package :zenBoi.pathNames)

(defparameter paname (make-pathname :directory '(:absolute "foo" "bar") :name "help"))

(print *DEFAULT-PATHNAME-DEFAULTS*)

(defun component-present-p (value);{{{
  (and value (not (eql value :unspecific))));}}}

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

;; ;; ;; ;; (defun list-directory (dirname);{{{
;; ;; ;; ;;   "Tries \"guarding\" the path name then calling the directory function on it"
;; ;; ;; ;;   (when (wild-pathname-p dirname)
;; ;; ;; ;;     (error "Can only list concrete directory names."))
;; ;; ;; ;;   (directory (directory-wildcard dirname)));}}}

(defun list-directory (dirname);{{{
  (when (wild-pathname-p dirname)
    (error "Can only list concrete directory names."))
  (let ((wildcard (directory-wildcard dirname)))

    ; Once you get all the implementations returning directories, you'll discover
    ; they can also differ in whether they return the names of directories in
    ; directory or file form. You want list-directory to always return directory
    ; names in directory form so you can differentiate subdirectories from
    ; regular files based on just the name. Except for Allegro, all the
    ; implementations this library will support do that. Allegro, on the other
    ; hand, requires you to pass DIRECTORY the implementation-specific keyword
    ; argument :directories-are-files NIL to get it to return directories in file
    ; form.

    #+(or sbcl cmu lispworks)
    (directory wildcard)

    #+openmcl
    (directory wildcard :directories t)

    #+allegro
    (directory wildcard :directories-are-files nil)

    #+clisp
    (nconc
     (directory wildcard)
     (directory (clisp-subdirectories-wildcard wildcard)))

    #-(or sbcl cmu lispworks openmcl allegro clisp)
    (error "list-directory not implemented")));}}}

#+clisp
(defun clisp-subdirectories-wildcard (wildcard);{{{ Pretty much just adds :wild to the directory component
  (make-pathname
   :directory (append (pathname-directory wildcard) (list :wild))
   :name nil
   :type nil
   :defaults wildcard));}}}

(defun file-exists-p (pathname);{{{
  #+(or sbcl lispworks openmcl)
  (probe-file pathname)

  #+(or allegro cmu)
  (or (probe-file (pathname-as-directory pathname))
      (probe-file pathname))

  #+clisp
  (or (ignore-errors
        (probe-file (pathname-as-file pathname)))
      (ignore-errors
        (let ((directory-form (pathname-as-directory pathname)))
          (when (ext:probe-directory directory-form)
            directory-form))))

  #-(or sbcl cmu lispworks openmcl allegro clisp)
  (error "file-exists-p not implemented"));}}}

(defun pathname-as-file (name);{{{
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (directory-pathname-p name)
      (let* ((directory (pathname-directory pathname))
             (name-and-type (pathname (first (last directory)))))
        (make-pathname
         :directory (butlast directory)
         :name (pathname-name name-and-type)
         :type (pathname-type name-and-type)
         :defaults pathname))
      pathname)));}}}

(defun walk-directory (dirname fn &key directories (test (constantly t)));{{{
  (labels
      ((walk (name)
         (cond
           ((directory-pathname-p name)
            (when (and directories (funcall test name))
              (funcall fn name))
            (dolist (x (list-directory name)) (walk x)))
           ((funcall test name) (funcall fn name)))))
    (walk (pathname-as-directory dirname)))) ;}}}

(merge-pathnames #p"foo/bar.html" #p"/www/html/")

;; It finally clicking, ... nothing better than pen and paper when the confusion strikes ...

paname ; #P"/foo/bar/help"

(pathname-type (pathname (first (last (pathname-directory paname)))))

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
