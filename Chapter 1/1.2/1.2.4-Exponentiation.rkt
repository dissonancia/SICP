#lang sicp
;; Chapter 1 - 1.2.4. Exponentiation

;; Exercise 1.16
(define (square x) (* x x))
(define (fast-expti b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter base counter product)
  (cond ((= counter 0) product)
        ((even? counter) (fast-expt-iter (square base)
                                         (/ counter 2)
                                         product))
        (else (fast-expt-iter base
                              (- counter 1)
                              (* base product)))))

;; Exercise 1.17
(define (double x)
  (+ x x))
(define (halve x)
  (/ x 2))

(define (mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (mult a (halve b))))
        (else (+ a (mult a (- b 1))))))

;; Exercise 1.18 
(define (multi a b)
  (mult-iter a b 0))
(define (mult-iter a b product)
  (cond ((= b 0) product)
        ((even? b) (mult-iter (double a)
                              (halve b)
                              product))
        (else (mult-iter a
                         (- b 1)
                         (+ a product)))))

;; Exercise 1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (* 2 p q) (square q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))