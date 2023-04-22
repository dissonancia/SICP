#!/usr/local/bin/guile -s!#

;; f by means of a recursive process

(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
	 (* 2 (f-rec (- n 2)))
	 (* 3 (f-rec (- n 3))))))

;; it's easy to define the recursive process
;; as a direct translation of the mathematical
;; function.

;; f by means of an iterative process

(define (f-iter n)
  (define (f-loop n-1 n-2 n-3 nth)
    (if (= n nth)
	n-1
	(f-loop (+ n-1 (* 2 n-2) (* 3 n-3)) n-1 n-2 (+ nth 1))))
  (if (< n 3)
      n
      (f-loop 2 1 0 2)))

;; to translate the recursive process to a
;; iterative one we can think in this way:
;; we need sufficient variables to store
;; the recursive calls and one more to be
;; an accumulator. In the function f we have
;; three recursive calls, so three variables
;; to store the recursive calls are sufficient.
;; The initial value of these variables are its
;; result in the base condition n < 3:
;; f(0) = 0 = n-3
;; f(1) = 1 = n-2
;; f(2) = 2 = n-1
;; Now we have to understand how each of the variables
;; is updated:
;; n-3 = n-2
;; n-2 = n-1
;; n-1 = n-1 + 2n-2 + 3n-3
;; the number of iterations is (n - 2) since when n is
;; less than three it will not iterate. So we'll set
;; an iteration from 2 to n.
