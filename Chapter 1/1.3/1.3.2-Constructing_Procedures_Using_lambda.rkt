#lang sicp
;; Chapter 1 - 1.3.2 Constructing Procedures Using lambda

(define (square x) (* x x))
(define (f g) (g 2))

;; Exercise 1.34
#|
Quando fazemos uma avaliação por ordem aplicativa, temos o
seguinte resultado:
(f f)
(f 2)
(2 2)
como 2 não é uma função, ocorre um erro.
|#