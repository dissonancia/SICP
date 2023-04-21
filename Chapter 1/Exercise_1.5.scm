#!/usr/local/bin/guile -s!#

(define (p) (p))        ; (define (p) (p)) is a procedure that evaluates to itself.

(define (test x y)
  (if (= x 0)
      0 
      y))

(test 0 (p)) 

;; In an applicative-order evaluation on (test 0 (p)), the arguments
;; are evaluated first and then applied. 0 will be evaluated to 0
;; and the (p) will be evaluated to itself, so we get stuck into an
;; infinite loop.
;;
;; In a normal-order evaluation on (test 0 (p)), first, operand
;; expressions are substituted for parameters until it obtained an
;; expression involving only primitive operators:
;;
;; (test 0 (p)) ->
;; (if (= 0 0) 0 (p)) ->
;; 0
;;
;; (= 0 0) will be evaluated as true and the consequent 0 is evaluated.
;; The (p) procedure will be not evaluated, avoiding an infinite loop.
