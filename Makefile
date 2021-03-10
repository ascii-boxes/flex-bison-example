
OUT_DIR = out
SRC_DIR = ../src
VPATH   = $(SRC_DIR)
CC      = gcc
CFLAGS  = -I. -I$(SRC_DIR) -Wall -W

.PHONY: all clean

all: | $(OUT_DIR)
	$(MAKE) -C $(OUT_DIR) -f ../Makefile calc

$(OUT_DIR):
	mkdir $(OUT_DIR)

parser.tab.c parser.tab.h: parser.y
	bison -t -v -d $<

lex.yy.c: lexer.l parser.tab.h
	flex $<

parser.o: parser.y

lex.yy.o: lex.yy.c parser.tab.h

calc: parser.o lex.yy.o
	$(CC) -o $@ $^

clean:
	rm -rf $(OUT_DIR)/
