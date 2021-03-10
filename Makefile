
OUT_DIR    = out
SRC_DIR    = ../src
VPATH      = $(SRC_DIR)

.PHONY: all clean

all: | $(OUT_DIR)
	$(MAKE) -C $(OUT_DIR) -f ../Makefile calc

$(OUT_DIR):
	mkdir $(OUT_DIR)

parser.tab.c parser.tab.h: parser.y
	bison -t -v -d $<

lex.yy.c: lexer.l parser.tab.h
	flex $<

calc: lex.yy.c parser.tab.c parser.tab.h
	gcc -o $@ parser.tab.c lex.yy.c

clean:
	rm -rf $(OUT_DIR)/
