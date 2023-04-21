#!/usr/local/bin/guile -s!#

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
	(else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

;; new-if is a function, not a special form, so each parameter
;; of new-if will be evaluated before the procedure is applied.
;; It means that both clauses will be evaluated even if the
;; predicate is not. And since the else-clause is a recursive call
;; to sqrt-iter the function will be stuck in a infinte loop.
