.PHONY: build test clean

TESTS  ?= true
OPTIONS=--tests ${TESTS}

build:
	ocaml pkg/pkg.ml build ${OPTIONS}

test: build
	ocaml pkg/pkg.ml test

clean:
	ocaml pkg/pkg.ml clean
