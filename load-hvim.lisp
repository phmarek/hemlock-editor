(cl:in-package :cl-user)

(ql:quickload :prepl)
(ql:quickload :alexandria)
(push #p"/home/no_backup/src/hemlock/" asdf:*central-registry*)

(declaim (optimize (debug 0) (speed 3)))
(sb-c::restrict-compiler-policy 'cl::debug 3) 
(sb-c::restrict-compiler-policy 'cl::safety 3) 

#+nil
(asdf:operate 'asdf:load-op :hemlock.qt)

(asdf:operate 'asdf:load-op :hemlock.clx) ;; shift defunct

#+nil
(asdf:operate 'asdf:load-op :hemlock.tty)


(use-package :hemlock-interface)

(defun start-hvim ()
  (setf (buffer-major-mode (current-buffer)) 
        "vim-normal")
  (insert-string (current-point)
                 (alexandria:read-file-into-string "INSTALL"))
  (sb-thread:make-thread
    (cl:lambda ()
               (hemlock:hemlock))
    :name "HEMLOCK"))

(start-hvim)
