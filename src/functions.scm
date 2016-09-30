; MU-puzzle functions

; returns last member of list l
(define last-member
  (lambda (l)
    (if (null? (cdr l)) ; if the list doesn't have a tail
      l                 ; the first element is also the last
      (last-member (cdr l))))) ; remove head of list

; returns first nth elements of list l
(define take
  (lambda (n l)
    (if (null? l) ; if the list is empty then it doesn't matter
      l
      (if (zero? n) ; if the number of elements is zero
        '() ; return an empty list
        ; add the element to the list
        ; and proceed to adding the other elements.
        (cons (car l) (take (- n 1) (cdr l)))))))

; appends U to the end of list l if it ends with I
(define xI->xIU
  (lambda (l)
    (if (equal? (car (last-member l)) 'I) ; check if list ends with I
      (append l '(U)) ; if it does, append U
      l))) ; if it doesn't, just return the list

; returns list l with a duplicated string x
; after the ith instance of the M character
(define Mx->Mxx
  (lambda (l i)
    (if (null? (cdr l))
      l
      (if (equal? (car l) 'M) ; check if the first char is an M
        (if (zero? i)         ; if it's the first instance
          (append l (cdr l))  ; duplicate
          (cons (car l) (Mx->Mxx (cdr l) (- i 1)))) ; otherwise move on
        (cons (car l) (Mx->Mxx (cdr l) i)))))) ; no M found, move on

; returns list l with the ith instance of III replaced with U
(define III->U
  (lambda (l i)
    (if (null? l)
      l
      (if (equal? '(I I I) (take 3 l)) ; check if the start is III
        (if (zero? i) ; if it's the first instance
          (cons 'U (III->U (cdddr l) (- i 1))) ; add an U, don't add the III
          (cons (car l) (III->U (cdr l) (- i 1)))) ; otherwise just move on
        (cons (car l) (III->U (cdr l) i)))))) ; move on if no III was seen

; returns list l without the ith instance of UU
(define dropUU
  (lambda (l i)
    (if (null? l)
      l
      (if (equal? '(U U) (take 2 l)) ; check start of list for UU
        (if (zero? i) ; when i is 0, the first UU found is dropped.
          (dropUU (cddr l) (- i 1)) ; i is now -1, so the function ends.
          (cons (car l) (dropUU (cdr l) (- i 1)))) ; no UU found, moving on
        (cons (car l) (dropUU (cdr l) i)))))) ; no UU found, check the rest
