#!/usr/local/bin/guile -s!#

(define (a-plus-abs-b a b)
  ((if (> b 0)
       +
       -)
   a b))

;; If the predicate “is b grater than 0?” is true, then the consequent “+”
;; is evaluated and the operation (+ a b) can be evaluated. Otherwise, if
;; the predicate is false, then the alternative “-” is evaluated and the
;; operation (- a b) can be evaluated.
;;
;; If b is positive it will remain positive, otherwise, if b is negative,
;; then the subtraction operation will negate it, turning it into a positive
;; number. In other words, we are doing a modulus operation on b: (+ a (abs b)).
