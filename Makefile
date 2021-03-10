
OUT_DIR    = out
SRC_DIR    = ../src
VPATH      = $(SRC_DIR)

.PHONY: all clean

all: | $(OUT_DIR)
	$(MAKE) -C $(OUT_DIR) -f ../Makefile calc

$(OUT_DIR):
	mkdir $(OUT_DIR)

calc.tab.c calc.tab.h: calc.y
	bison -t -v -d $<

lex.yy.c: calc.l calc.tab.h
	flex $<

calc: lex.yy.c calc.tab.c calc.tab.h
	gcc -o $@ calc.tab.c lex.yy.c

clean:
	rm -rf $(OUT_DIR)/
