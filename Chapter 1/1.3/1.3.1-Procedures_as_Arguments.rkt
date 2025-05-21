#lang sicp
;; Chapter 1 - 1.3.1 Procedures as Arguments

;; estrutura formal de uma soma de série (recursiva)
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;; soma de cubos
(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (iter-sum cube a inc b))

;; soma de inteiros
(define (identity x) x)
(define (sum-integers a b)
  (iter-sum identity a inc b))

;; aproximação de PI
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (iter-sum pi-term a pi-next b))

;; aproximação integral
(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (iter-sum f (+ a (/ dx 2.0)) add-dx b) dx))

;; Exercise 1.29: Simpson’s Rule
(define (simpson-integral f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (simpson-term k)
    (* (y k)
       (cond ((or (= k 0) (= k n)) 1)
             ((odd? k) 4)
             (else 2))))
  (* (/ h 3.0)
     (iter-sum simpson-term 0 inc n)))

#|
Como podemos observar pelos resultados dos testes,
a regra de Simpson deu resultados extremamente melhores.
|#

;; Exercise 1.30
(define (iter-sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

;; Exercise 1.31.a)
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial n)
  (product identity 1 inc n))

(define (wallis-product n)
  (define (term n)
    (* (/ (* 2 n)
          (- (* 2 n) 1))
       (/ (* 2 n)
          (+ (* 2 n) 1))))
  (* (product term 1.0 inc n) 2))

;; Exercise 1.31.b)
(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-rec term (next a) next b))))

;; Exercise 1.32.a)
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (acc-sum term a next b)
  (accumulate + 0 term a next b))

(define (acc-prod term a next b)
  (accumulate * 1 term a next b))

;; Exercise 1.32.b)
(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate-rec combiner null-value term (next a) next b))))

;; Exercise 1.33
(define (filtered-accumulate combiner predicate null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (cond ((predicate a) (iter (next a) (combiner (term a) result)))
              (else (iter (next a) (combiner null-value result))))))
  (iter a null-value))

;a)

(define (next n)
  (if (= n 2)
      3
      (+ n 2)))
(define (square x) (* x x))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (smallest-divisor n) (find-divisor n 2))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n(smallest-divisor n)))

(define (sum-of-squares-prime a b)
  (filtered-accumulate + prime? 0 square a inc b))

; b)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-of-relative-prime n)
  (define (relative-prime? i)
    (= (gcd i n) 1))
  (filtered-accumulate * relative-prime? 1 identity 1 inc (- n 1)))