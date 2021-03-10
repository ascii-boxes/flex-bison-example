
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

parser.c parser.h: parser.y
	bison -t -v -d -o parser.c $<

lex.yy.c lex.yy.h: lexer.l parser.h
	flex --header-file=lex.yy.h $<

parser.o: parser.c
lex.yy.o: lex.yy.c parser.h
main.o: main.c parser.h lex.yy.h

calc: main.o parser.o lex.yy.o
	$(CC) -o $@ $^

clean:
	rm -rf $(OUT_DIR)/
