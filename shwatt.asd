(defsystem :shwatt
  :author "Karl Hallsby <karl@hallsby.com>"
  :description "Simulating HardWare and Time Traveling"
  :pathname #p"source/"
  :components ((:file "shwatt"))
  :depends-on (:log4cl)
  :in-order-to ((test-op (test-op "shwatt/tests"))))

(defsystem :shwatt/tests
  :depends-on (:shwatt :alexandria :lisp-unit2)
  :pathname #p"tests/"
  :components ((:file "example")))

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :shwatt/tests))))
  ;; Binding `*package*' to package-under-test makes for more reproducible tests.
  (let ((*package* (find-package :shwatt/tests)))
    (uiop:symbol-call
     :lisp-unit2 :run-tests
     :package *package*
     :name :shwatt
     :run-contexts (find-symbol "WITH-SUMMARY-CONTEXT" :lisp-unit2))))
