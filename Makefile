.PHONY: build test install uninstall reinstall clean

FINDLIB_NAME=github-hooks
MOD_NAME=github_hooks

OCAMLBUILD=ocamlbuild -use-ocamlfind -classic-display

WITH_UNIX=$(shell ocamlfind query unix > /dev/null 2>&1 ; echo $$?)

TARGETS=.cma .cmxa .cmx

PRODUCTS=$(addprefix $(MOD_NAME),$(TARGETS))

ifeq ($(WITH_UNIX), 0)
PRODUCTS+=$(addprefix $(MOD_NAME)_unix,$(TARGETS))
endif

TYPES=.mli .cmi .cmti

INSTALL:=$(addprefix $(MOD_NAME), $(TYPES)) \
         $(addprefix $(MOD_NAME), $(TARGETS))

INSTALL:=$(addprefix _build/lib/,$(INSTALL))

ifeq ($(WITH_UNIX), 0)
INSTALL_UNIX:=$(addprefix $(MOD_NAME)_unix,$(TYPES) $(TARGETS))
INSTALL_UNIX:=$(addprefix _build/unix/,$(INSTALL_UNIX))

INSTALL+=$(INSTALL_UNIX)
endif

ARCHIVES:=_build/lib/$(MOD_NAME).a

ifeq ($(WITH_UNIX), 0)
ARCHIVES+=_build/unix/$(MOD_NAME)_unix.a
endif

build:
	$(OCAMLBUILD) $(PRODUCTS)

test: build
	$(OCAMLBUILD) test/test_hook_server.native
	./test_hook_server.native

install:
	ocamlfind install $(FINDLIB_NAME) META \
		$(INSTALL) \
		$(ARCHIVES)

uninstall:
	ocamlfind remove $(FINDLIB_NAME)

reinstall: uninstall install

clean:
	ocamlbuild -clean
