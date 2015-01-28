LIB=UXXXX
LIB_FILES=$(addprefix $(LIB)., a cmxa cma cmi)

all: $(LIB_FILES)

$(LIB_FILES):
	ocamlbuild $@

install: META $(LIB_FILES)
	ocamlfind install $(LIB) META $(addprefix _build/, $(LIB_FILES))

uninstall:
	ocamlfind remove $(LIB)

clean:
	ocamlbuild -clean
