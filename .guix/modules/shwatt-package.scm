;;; SHWaTT --- Tcl/Tk to Common Lisp transpiler
;;; Copyright © 2023 Karl Hallsby <karl@hallsby.com>
;;;
;;; This file is part of SHWaTT.
;;;
;;; SHWaTT is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; SHWaTT is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with SHWaTT.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; GNU Guix development package.  To build and install, run:
;;
;;   guix package -f guix.scm
;;
;; To use as the basis for a development environment, run:
;;
;;   guix shell -D -f guix.scm
;;
;;; Code:
(define-module (shwatt-package)
  #:use-module (ice-9 popen) ;; These first packages are needed to build guix.scm description
  #:use-module (ice-9 rdelim)
  #:use-module ((guix build utils) #:select (with-directory-excursion))
  ;; Stuff to build the package
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp-check))

(define vcs-file?
  ;; Return true if the given file is under version control.
  (or (git-predicate
       (string-append (current-source-directory) "/../.."))
      (const #t)))

(define-public shwatt
  (package
   (name "shwatt")
   (version "0.1")
   (source (local-file "../.." "shwatt-checkout"
                       #:recursive? #t
                       #:select? vcs-file?))
   (native-inputs
    (list sbcl
          cl-lisp-unit2
          cl-log4cl
          ;; Building the manual
          autoconf automake texinfo))
   (inputs
    (list cl-alexandria
          cl-slime-swank
          cl-slynk))
   (build-system asdf-build-system/sbcl)
   ;; (build-system asdf-build-system/source) ;; Maybe use this?
   (arguments
    (list
     #:phases
     #~(modify-phases %standard-phases
         (add-after 'check 'install-manual
           (lambda* (#:key (configure-flags '()) (make-flags '()) outputs
                     #:allow-other-keys)
             (let* ((out  (assoc-ref outputs "out"))
                    (info (string-append out "/share/info")))
               (invoke "./bootstrap")
               (apply invoke "sh" "./configure" "SHELL=sh" configure-flags)
               (apply invoke "make" "info" make-flags)
               (install-file "doc/shwatt.info" info))))
         (add-after 'check 'install-binary
           (lambda* (#:key (configure-flags '()) (make-flags '()) outputs
                     #:allow-other-keys)
             (let* ((out  (assoc-ref outputs "out"))
                    (bin (string-append out "/bin")))
               (invoke "./bootstrap")
               (apply invoke "sh" "./configure" "SHELL=sh" configure-flags)
               (apply invoke "make" "executable" make-flags)
               (install-file "bin/shwatt" bin)))))))
   (synopsis "Simulating HardWare and Time Traveling")
   (description "SHWaTT (Simulating HardWare and Time Traveling).")
   (home-page "http://github.com/Chil-HW/shwatt")
   (license gpl3+)))

shwatt
