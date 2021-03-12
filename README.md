A small example of a calculator written with flex / bison.

Install prerequisites. On Debian-based Linuxes, like:

    $ apt-get install -y build-essential flex bison

Build using the `Makefile`

    $ make

then run like so:

    $ out/calc

Exit the calculator with `exit` command or *Ctrl-D*.


### Difference from meyerd/flex-bison-example

This fork of [meyerd/flex-bison-example](https://github.com/meyerd/flex-bison-example) adds:

- reentrant parser
- pass custom parameters to parser and lexer
- get custom data back from parser and lexer
- compile source files individually, then link (as you would do in a larger code base)
- separate sources and generated files into `src` and `out` dirs
