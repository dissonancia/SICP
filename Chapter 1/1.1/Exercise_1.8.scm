#!/usr/local/bin/guile -s!#

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (cube-root-iter guess old-guess x)
  (if (good-enough? guess old-guess)
      guess
      (cube-root-iter (improve guess x) guess x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess old-guess)
  (< (abs (- guess old-guess)) 0.00000000001))

(define (cube-root x)
  (cube-root-iter 1.0 0.0 x))
