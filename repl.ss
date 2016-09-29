(load "functions.ss")

(newline) (display "MU-puzzle REPL")
(newline) (display "Note that the positions are zero-indexed.")
(newline) (display "Copyright Luiz de Milon, 2016")
(newline) (newline)

(define repl
  (lambda (is)
    (newline)
    (display "What function do you want to apply?") (newline)
    (display "1: xI -> xIU")                        (newline)
    (display "2: Mx -> Mxx")                        (newline)
    (display "3: III -> U")                         (newline)
    (display "4: Drop UU")                          (newline)
    (display "Current string: ") (display is)       (newline)

    (let ((cmd (read)))
      (repl
        (if (equal? cmd 1)
          (xI->xIU is)
          (begin
            (display "Apply at what position? ")
            (let ((pos (read)))
              (cond
                ((equal? cmd 2) (Mx->Mxx is pos))
                ((equal? cmd 3) (III->U is pos))
                ((equal? cmd 4) (dropUU is pos))))))))))

(repl '(M I))
