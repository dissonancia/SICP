#lang sicp
;; Chapter 1 - 1.3.3 Procedures as General Methods

;; Finding roots of equations by the half-interval method

(define (average x y) (/ (+ x y) 2.0))
(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

;; Finding fixed points of functions

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
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

;; Exercise 1.36

(define (report-fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (f x)
  (report-fixed-point (lambda (x) (average x (/ (log 1000) (log x))))
                      1.5))

;; com a entrada 5 e o chute inicial de 1.5
;; sem o average damping o resultado foi alcançado em 35 passos

;; com a entrada 5 e o chute inicial de 1.5
;; com o average damping o resultado foi alcançado em 11 passos

;; O average damping reduziu o número de passos em cerca de 68,6%.

;; --------------------------------------------------------------------------

;; Exercise 1.37

;; a)

;; 1/ϕ = 0.6180339887...

(define (cont-frac n d k)
  (define (recur i)
    (if (= k i)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (recur (+ i 1))))))
  (recur 1))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)

;; O k deve ser igual a pelo menos 11 para que o resultado tenha precisão
;; de quatro casas deciamais.

;; b)

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (/ (n i) (+ (d i) result)))))
  (iter (- k 1) (/ (n k) (d k))))

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                11)

;; --------------------------------------------------------------------------

;; Exercise 1.38

(define (d-euler i)
  (if (= (modulo i 3) 2)
      (* 2 (/ (+ i 1) 3))
      1))

; valor exato é 0.718281828459
(cont-frac-iter (lambda (i) 1.0)
                d-euler
                17)

;; --------------------------------------------------------------------------

;; Exercise 1.39

(define (square x) (* x x))
(define (d-tan i)
  (+ (* 2 i) 1))
(define (x-tan x i)
  (if (= i 0)
      x
      (square x)))

(define (tan-cf x k)
  (define (recur i)
    (if (= k i)
        (/ (x-tan x i) (d-tan i))
        (/ (x-tan x i) (- (d-tan i) (recur (+ i 1))))))
  (recur 0))

; tan(1) = 1.55740772465
(tan-cf 1.0 7)