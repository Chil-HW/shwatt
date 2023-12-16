(defpackage shwatt
  (:use :cl :log4cl)
  (:export #:hello))

(in-package :shwatt)

(defun hello ()
  (let ((msg (format 'nil "Hello to SHWaTT!")))
    (log:info msg)
    (when (log:debug)
      (log:debug "This is a fancy debugger!"))))
