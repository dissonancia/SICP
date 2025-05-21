#lang sicp
;; Chapter 1 - 1.3.4 Procedures as Returned Values

(define (square x) (* x x))
(define (cube x) (* x x x))
(define (average a b)
  (/ (+ a b)
     2.0))
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (f-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))
;; --------------------------------------------------------------------------
;; Newton’s method

(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (n-sqrt x)
  (newtons-method
   (lambda (y) (- (square y) x)) 1.0))

;; --------------------------------------------------------------------------
;; Abstractions and first-class procedures

(define (fixed-point-transform g transform guess)
  (fixed-point (transform g) guess))

(define (gf-sqrt x)
  (fixed-point-transform
   (lambda (y) (/ x y)) average-damp 1.0))

(define (gn-sqrt x)
  (fixed-point-transform
   (lambda (y) (- (square y) x)) newton-transform 1.0))

;; --------------------------------------------------------------------------

;; Exercise 1.40

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

(define (n-cubic a b c)
  (newtons-method (cubic a b c) 1))

;; --------------------------------------------------------------------------

;; Exercise 1.41

(define (inc n) (+ n 1))
(define (double f)
  (lambda (x) (f (f x))))

(((double (double double)) inc) 5)
; retorna 21

;; --------------------------------------------------------------------------

;; Exercise 1.42

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)
; retorna 49

;; --------------------------------------------------------------------------

;; Exercise 1.43

; Apenas com funções lambdas
(define (y-repeated f n)
  (if (= n 1)
      f
      (lambda (x) (f ((y-repeated f (- n 1)) x)))))

((y-repeated square 2) 5)
; 625

; Usando compose
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

((repeated square 2) 5)
; 625

; Como podemos observar, usando o compose a função fica mais
; fácil de entender.

;; --------------------------------------------------------------------------

;; Exercise 1.44

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0)))

(define (smooth-nth f n)
  ((repeated smooth n) f))

;; --------------------------------------------------------------------------

;; Exercise 1.45

(define (fast-expt b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter base counter product)
  (cond ((= counter 0) product)
        ((even? counter) (fast-expt-iter (square base)
                                         (/ counter 2)
                                         product))
        (else (fast-expt-iter base
                              (- counter 1)
                              (* base product)))))

(define (times n)
  (+ 1 (quotient n 4)))

(define (sqrt-nth n x)
  (fixed-point-transform
   (lambda (y) (/ x (fast-expt y (- n 1)))) (repeated average-damp (times n)) 1.0))

#|
É observado que até chegar na raiz quarta usamos o average damp apenas uma vez
e apartir dela precisamos aplicar o average damp duas vezes. A necessidade de
aplicar o average damp uma terceira vez só aparece na raiz oitava. Com isso,
concluimos que a cada múltiplo de 4 o número de vezes que o average damp precisa
ser aplicado para que haja convergência é de +1.
|#

;; --------------------------------------------------------------------------

;; Exercise 1.46

; sqrt com iterative-improve

(define (iterative-improve-sqrt good-enough? improve-guess)
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve-guess guess))))
  (lambda (guess) (iter guess)))

(define (ii-sqrt x)
  (define (average a b)
    (/ (+ a b) 2))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  ((iterative-improve-sqrt good-enough? improve) 1.0))

(ii-sqrt 25)

; fixed-point com iterative-improve

(define (iterative-improve good-enough? improve-guess)
  (define (iter guess)
    (let ((next (improve-guess guess)))
      (if (good-enough? guess next)
          next
          (iter next))))
  (lambda (guess) (iter guess)))

(define (ii-fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  ((iterative-improve close-enough? f) 1.0))

(define (iif-sqrt x)
  (ii-fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(define (iif-cube-root x)
  (ii-fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

(iif-sqrt 25)
; 5
(iif-cube-root 27)
; 2.9999972321057697