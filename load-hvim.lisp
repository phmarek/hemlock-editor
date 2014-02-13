(ql:quickload :prepl)

(declaim (optimize (debug 0) (speed 3)))
(sb-c::restrict-compiler-policy 'cl::debug 3) 
(sb-c::restrict-compiler-policy 'cl::safety 3) 

#+nil
(asdf:operate 'asdf:load-op :hemlock.qt)

(asdf:operate 'asdf:load-op :hemlock.clx) ;; shift defunct

#+nil
(asdf:operate 'asdf:load-op :hemlock.tty)


(cl:in-package :hemlock-interface)


(defun cl-user:start-hvim ()
  (setf 
    (buffer-major-mode (current-buffer))
    "vim-normal")
  (insert-string (current-point)
                 (alexandria:read-file-into-string "INSTALL"))
  (sb-thread:make-thread
    (cl:lambda ()
      (hemlock:hemlock))
    :name "HEMLOCK"))

(cl-user:start-hvim)
