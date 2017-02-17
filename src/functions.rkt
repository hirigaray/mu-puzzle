#lang racket

(provide
  xI->xIU
  Mx->Mxx
  III->U
  dropUU)

; appends U to the end of list l if it ends with I
(define (xI->xIU l)
  (if (equal? 'I (last l))
    (reverse (cons 'U (reverse l)))
    l))

; returns list l with a duplicated string x
; after the ith instance of the M character
(define (Mx->Mxx l i)
  ; if cnt is zero, the next Mx will be duplicated
  ; str stores the string before the current Mx
  (let aux ((in l) (cnt i) (str '()) (out '()))
    (if (null? in)
      (append (reverse str) out)
      (if (zero? cnt)
        (if (equal? 'M (car in))
          (aux '() cnt str (append in (cdr in)))
          (aux (cdr in) cnt (cons (car in) str) out))
        (aux (cdr in) (- cnt 1) (cons (car in) str) out)))))

(define (III->U l i)
  ; if cnt is zero, the next '(I I I) will be replaced by 'U
  (let aux ((in l) (cnt i) (out '()))
    (if (null? in)
      (reverse out)
      (if (>= (length in) 3)
        (if (equal? '(I I I) (take in 3))
          (if (zero? cnt)
            (aux (cdddr in) cnt (cons 'U out))
            (aux (cdr in) (- cnt 1) (cons (car in) out)))
          (aux (cdr in) cnt (cons (car in) out)))
        (aux (cdr in) cnt (cons (car in) out))))))

; returns list l without the ith instance of UU
(define (dropUU l i)
  (let aux ((in l) (cnt i) (out '()))
    (if (null? in)
      (reverse out)
      (if (>= (length in) 2)
        (if (equal? '(U U) (take in 2))
          (if (zero? cnt)
            (aux (cddr in) (- cnt 1) out)
            (aux (cdr in) (- cnt 1) (cons (car in) out)))
          (aux (cdr in) cnt (cons (car in) out)))
        (aux (cdr in) cnt (cons (car in) out))))))
