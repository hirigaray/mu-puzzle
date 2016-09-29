; MU-puzzle implementation

(define last-member
  (lambda (l)
    (if (null? (cdr l))
      l
      (last-member (cdr l)))))

(define take
  (lambda (n l)
    (if (null? l)
      l
      (if (zero? n)
        '()
        (cons (car l) (take (- n 1) (cdr l)))))))

(define xI->xIU
  (lambda (l)
    (if (equal? (car (last-member l)) 'I)
      (append l '(U)))))

(define Mx->Mxx
  (lambda (l i)
    (if (null? (cdr l))
      l
      (if (equal? (car l) 'M)
        (if (equal? i 0)
          (append l (cdr l))
          (cons (car l) (Mx->Mxx (cdr l) (- i 1))))
        (cons (car l) (Mx->Mxx (cdr l) i))))))

(define III->U
  (lambda (l i)
    (if (null? l)
      l
      (if (equal? '(I I I) (take 3 l))
        (if (equal? i 0)
          (cons 'U (III->U (cdddr l) (- i 1)))
          (cons (car l) (III->U (cdr l) (- i 1))))
        (cons (car l) (III->U (cdr l) i))))))

(define dropUU
  (lambda (l i)
    (if (null? l)
      l
      (if (equal? '(U U) (take 2 l))
        (if (equal? i 0)
          (dropUU (cddr l) (- i 1))
          (cons (car l) (dropUU (cdr l) (- i 1))))
        (cons (car l) (dropUU (cdr l) i))))))
