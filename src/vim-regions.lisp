(in-package :hemlock-vim)


;; The (DEFCOMMAND) macro builds a function symbol from the
;; case-folded command name, so differentiating via "Word" and "word"
;; doesn't work.
;; We use "+" to provide a sign ;)



(defun setup-region (buffer)
  "Clears *REGION*."
  (declare (ignore buffer))
  (setf *region* nil))


(defun apply-action-to-region (buffer)
  "Applies *ACTION* to *REGION*."
  (when (and *action* *region*)
    (funcall *action* *region*)))


;; how to get _any_ key, eg. to ignore unbound in normal mode?
;; can the repetition argument be passed along?
;; hi::*prefix-argument-supplied*


(defmacro defregion ((name arg &key
                           (start 'start)
                           (end 'end))
                     &body body)
  (let ((c-n (format nil "Region ~a" name))
        (c-d (format nil "Set the region by ~a." name)))
    `(defcommand ,c-n (,arg)
       ,c-d
       ,c-d
       (with-mark ((,start (current-point)))
         (declare (ignorable ,start))
         (with-mark ((,end (current-point)))
           (declare (ignorable ,end))
           ,@ body
           ,@(unless (find '*region*
                            (alexandria:flatten body)
                            :test #'eq)
               (list `(setf *region* (region ,start ,end))))
           (into-normal-mode-command nil))))))

;; TODO: handle count
(defregion ("Line" p)
           ;; TODO
    (setf *region* (line-to-region (current-point))))

   
(defregion ("characters" p)
    (character-offset end (or p 1)))

(defregion ("word" p)
    (word-offset end (or p 1)))
(defregion ("+Word" p)
           ;; TODO
    (word-offset end (or p 1)))
(defregion ("a word" p)
           ;; TODO
    (word-offset start -1)
    (word-offset end (or p 1)))
(defregion ("a +word" p)
           ;; TODO
    (word-offset start -1)
    (word-offset end (or p 1)))



(in-mode ("vim-region/object")
  (bind-key "Into Normal Mode" #k"escape")
  (bind-key "Into Normal Mode" #k"control-c")

  (bind-key "Region A word" #k"a w")
  (bind-key "Region A +Word" #k"a W")

  (bind-key "Region word" #k"w")
  (bind-key "Region +Word" #k"W")

  (bind-key "Region character" #k"l")

  (bind-key "Region End of Word" #k"e"))

 
