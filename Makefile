MLI	=	utils/dom.mli \
		lib/isomer_point.mli \
		lib/isomer_color.mli \
		lib/isomer_canvas.mli \
		lib/isomer_path.mli \
		lib/isomer_shape.mli \
		lib/isomer_vector.mli \
		lib/isomer.mli

ML	=	$(MLI:.mli=.ml)

CMI	=	$(MLI:.mli=.cmi)

CMO	=	$(ML:.ml=.cmo)

%.ml:	%.mli
	ocamlfind gen_js_api/gen_js_api $<

%.cmi:	%.mli
	ocamlfind ocamlc -c -I utils -I lib -package gen_js_api $<

%.cmo:	%.ml
	ocamlfind ocamlc -c -I utils -I lib -package gen_js_api $<

all:	$(CMI) $(CMO)
	ocamlfind ocamlc -c -I utils -I lib test.ml
	ocamlfind ocamlc -no-check-prims -linkpkg -package gen_js_api $(CMO) test.cmo -o test.byte
	js_of_ocaml --pretty -o html/test.js +gen_js_api/ojs_runtime.js test.byte

clean_gen: $(ML)
	   rm -f $(ML)

clean:	$(ML) $(CMI) $(CMO)
	rm -f $(ML) $(CMI) $(CMO)
	rm -f test.cmi test.cmo

fclean: clean
	rm -f html/test.js
	rm -f test.byte

.PHONY:	all clean fclean
