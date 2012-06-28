
OPA=opa
OPAPLUGIN=opa-plugin-builder

SRC= \
  parsing/parser.opa \
	parsing/assign_id.opa \
  pretty_printers/string_printer.opa \
	riskybird_utils.opa

BINDINGS= \
  riskybird_binding.js

BINDINGS_OBJ=$(BINDINGS:.js=.opp)

default: run

run: riskybird.exe
	./riskybird.exe

test: riskybird_unittest.exe
	./riskybird_unittest.exe

riskybird.exe: $(BINDINGS_OBJ) $(SRC) riskybird.opa
	$(OPA) -o riskybird.exe $(SRC) riskybird.opa

riskybird_unittest.exe: $(BINDINGS_OBJ) $(SRC) unittest.opa
	$(OPA) -o riskybird_unittest.exe $(SRC) unittest.opa

clean:
	rm -Rf *~ *.exe *.log _build/ *.opp

$(SRC):

%.opp: %.js
	$(OPAPLUGIN) -o $(@:.opp=) $<
