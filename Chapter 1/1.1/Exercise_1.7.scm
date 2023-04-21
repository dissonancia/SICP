#!/usr/local/bin/guile -s!#

(define (square x)
  (* x x))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

;; Square Roots by Newton’s Method

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

;; new approach

(define (sqrt-iter guess old-guess x)
  (if (good-enough? guess old-guess)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (good-enough? guess old-guess)
  (< (abs (- guess old-guess)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 0.0 x))

;; In the original approach, for larger numbers, 
;; mostly of the time, the computation will not finish.
;; That's because of the computer round problems for
;; floating point representation. When it gets close
;; to the result, the improve function can't improve anymore
;; as the difference of x and guess² is larger than 0.001
;; and will always return the same result.
;;
;; For small numbers, if it is smaller than 0.001 the
;; result will be inaccurate as the good-enough? function
;; will find a “good enough” result in few iterations.
