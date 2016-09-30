;(load "src/functions.ss")
(load "src/repl.ss")

(newline) (display "Copyright (c) Luiz de Milon, 2016")
(newline) (display "This program is distributed under the ISC license.")
(newline) (display "See LICENSE for details.")
(newline)
(newline) (display "MU-puzzle REPL")
(newline) (display "Note that the positions are zero-indexed.")
(newline) (display "Ctrl-D terminates.")
(newline)

(repl '(M I))
