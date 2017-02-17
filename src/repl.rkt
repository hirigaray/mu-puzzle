#lang racket

(require "functions.rkt")

(provide repl)

(define repl
  (lambda (s)
    (newline)
    (display "What function do you want to apply?") (newline)
    (display "1) xI -> xIU")                        (newline)
    (display "2) Mx -> Mxx")                        (newline)
    (display "3) III -> U")                         (newline)
    (display "4) Drop UU")                          (newline)
                                                    (newline)
    (display "Current string: ")                    (newline)
    (display s) (display "> ")

    (let ((cmd (read)))
      (repl
        (if (equal? cmd 1)
          (xI->xIU s)
          (if (eof-object? cmd)
            (exit)
            (begin
              (display "Apply at what position? ")
              (let ((pos (read)))
                (cond
                  ((equal? cmd 2) (Mx->Mxx s pos))
                  ((equal? cmd 3) (III->U s pos))
                  ((equal? cmd 4) (dropUU s pos)))))))))))

