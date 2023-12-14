(defpackage shwatt
  (:use :cl)
  (:export #:hello))

(in-package :shwatt)

(defun hello ()
  (format t "Hello to SHWaTT!~&"))
