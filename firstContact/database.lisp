(defvar *db* nil)

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(add-record (make-cd "Rosy" "toot" "meh" nil))

(defun add-record (cd) (push cd *db*))

(defun dump-db ()  
  (dolist (cd *db*)    
    (print cd)
    (format t "~%")
    (format t "~{~a:~10t~a~%~}~%" cd)))

(dump-db)

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
    (prompt-read "Title")
    (prompt-read "Artist")
    (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
    (y-or-n-p (prompt-read "Ripped? (y/n)"))))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
        (if (not (y-or-n-p "Another [y/n]")) (return))))

(defun save-db (filename)  
  (with-open-file (out filename                   
                       :direction :output                   
                       :if-exists :supersede)    
    (with-standard-io-syntax      
      (print *db* out))))

(save-db "~/data.db")


(defun load-db (filename)  
  (with-open-file (in filename)    
    (with-standard-io-syntax      
      (setf *db* (read in)))))

(defun foo (&key a (b 20) (c 30 c-p)) (list a b c c-p))

;;;; (defun where (&key title artist rating (ripped nil ripped-p))  
;;;;   #'(lambda (cd)      
;;;;       (and       
;;;;         (if title    (equal (getf cd :title)  title)  t)       
;;;;         (if artist   (equal (getf cd :artist) artist) t)       
;;;;         (if rating   (equal (getf cd :rating) rating) t)       
;;;;         (if ripped-p (equal (getf cd :ripped) ripped) t))))


(defun zenPlaying (&KEY a)
  (if a 
      (print "Kek, a was, indeed, passed as a keyword arg")
      (print "The keyword arg a was not passed")))

(zenPlaying) ; => The keyword arg a was not passed

(zenPlaying :a "foo"); => Kek, a was, indeed, passed as a keyword arg

(defun select (selector-fn)  
  (remove-if-not selector-fn *db*))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))  
  (setf *db*        
        (mapcar         
          #'(lambda (row)             
              (when (funcall selector-fn row)               
                (if title    (setf (getf row :title) title))               
                (if artist   (setf (getf row :artist) artist))               
                (if rating   (setf (getf row :rating) rating))               
                (if ripped-p (setf (getf row :ripped) ripped)))             
              row) *db*)))

(defun delete-rows (selector-fn)
 (setf *db* (remove-if selector-fn *db*)))

(defun make-comparison-expr (field value)
 `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields 
        collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
 `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

