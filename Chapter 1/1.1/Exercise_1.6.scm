#!/usr/local/bin/guile -s!#

(define (square x)
  (* x x))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; new-if definition and utilization in sqrt function

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
	(else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;; new-if is a function, not a special form, so each parameter
;; of new-if will be evaluated before the procedure is applied
;; (applicative-order). It means that both clauses will be evaluated
;; even if the predicate is not. And since the else-clause is a recursive
;; call to sqrt-iter the function will be stuck in a infinte loop.
