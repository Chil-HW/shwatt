LISP_PROG := @LISP_PROGRAM@
LISP_FLAGS := --no-userinit --non-interactive

makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

lisp_eval := $(LISP_PROG) $(LISP_FLAGS) \
             --eval '(require "asdf")' \
             --eval '(asdf:load-asd "$(makefile_dir)/shwatt.asd")' \
             --eval

lisp_quit := --eval '(uiop:quit)'

shwatt_files := shwatt.asd $(shell find . -type f -name '*.lisp')

.PHONY: build
build: $(shwatt_files)
	$(lisp_eval) '(asdf:compile-system :shwatt)'

shwatt_tests := shwatt.asd $(shell find ./tests/ -type f -name '*.lisp')
.PHONY: check
check: $(shwatt_files) $(shwatt_tests)
	$(lisp_eval) '(asdf:test-system :shwatt)'

include doc/local.mk
