(defpackage shwatt
  (:use :cl :log4cl)
  (:export #:hello))

(in-package :shwatt)

(defun handle-ir ()
  "Read the IR and convert to simulator's internal representation of the circuit,
which is amenable to simulation."
  (log:trace "Starting to handle IR")
  nil)

(defun simulate ()
  "Simulate the provided circuit."
  (log:trace "Simulation starting")
  nil)

(defun hello ()
  (log:config :trace)
  (progn
    (let ((msg (format 'nil "Hello to SHWaTT!")))
      (log:info msg)
      (when (log:debug)
        (log:debug "This is a fancy debugger!")))
    (handle-ir)
    (simulate)))
