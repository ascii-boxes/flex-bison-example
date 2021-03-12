# flex-bison-example

**A reentrant example parser with custom parameters with flex/bison**

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
- print line number in error messages
- compile source files individually, then link (as you would do in a larger code base)
- separate sources and generated files into `src` and `out` dirs


### Resources

Helpful links that I used:

- [Make a reentrant parser with Flex and Bison](https://www.lemoda.net/c/reentrant-parser/index.html)
- [The Flex Manual](http://westes.github.io/flex/manual/index.html)
- [The Bison Manual](https://www.gnu.org/software/bison/manual/html_node/index.html)
- [Configuring Bison and Flex without global or static variable](https://stackoverflow.com/q/22107203/1005481)
