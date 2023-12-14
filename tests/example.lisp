(defpackage :shwatt/tests
  (:use :cl :lisp-unit2))

(in-package :shwatt/tests)

(define-test example ()
  (assert-eql 1 (- 2 1)))
