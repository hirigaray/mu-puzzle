#lang racket

(provide
  xI->xIU
  Mx->Mxx
  III->U
  dropUU)

; appends U to the end of list l if it ends with I
(define (xI->xIU l)
  (cond
    [(not (equal? 'I (last l))) l]
    [else (reverse (cons 'U (reverse l)))]))

; returns list l with a duplicated string x after the ith instance of the M character
(define (Mx->Mxx l i)
  ; str stores the string before the current Mx
  (let aux ((in l) (cnt i) (str '()) (out '()))
    (cond
      [(null? in) (append (reverse str) out)]
      [(not (zero? cnt)) (aux (cdr in) (- cnt 1) (cons (car in) str) out)]
      [(not (equal? 'M (car in))) (aux (cdr in) cnt (cons (car in) str) out)]
      [else (aux '() cnt str (append in (cdr in)))])))

; returns list l with the ith instance of '(I I I) replaced with 'U
(define (III->U l i)
  (let aux ((in l) (cnt i) (out '()))
    (cond
      [(null? in) (reverse out)]
      [(not (>= (length in) 3)) (aux (cdr in) cnt (cons (car in) out))]
      [(not (zero? cnt)) (aux (cdr in) (- cnt 1) (cons (car in) out))]
      [(not (equal? '(I I I) (take in 3))) (aux (cdr in) cnt (cons (car in) out))]
      [else (aux (cdddr in) cnt (cons 'U out))])))

; returns list l without the ith instance of UU
(define (dropUU l i)
  (let aux ((in l) (cnt i) (out '()))
    (cond
      [(null? in) (reverse out)]
      [(not (>= (length in) 2)) (aux (cdr in) cnt (cons (car in) out))]
      [(not (zero? cnt)) (aux (cdr in)  (- cnt 1) (cons (car in) out))]
      [(not (equal? '(U U) (take in 2))) (aux (cdr in) cnt (cons (car in) out))]
      [else (aux (cddr in) (- cnt 1) out)])))
