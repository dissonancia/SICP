#lang sicp
;; 1.2.6 Example: Testing for Primality
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

;; Fermat test
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;; Exercise 1.21
(smallest-divisor 199)
; 199
(smallest-divisor 1999)
; 1999
(smallest-divisor 19999)
; 7

;; Exercise 1.22
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes initial-number count)
  (if (even? initial-number)
      (search-for-primes (+ initial-number 1) count)
      (cond ((= count 0)
             (newline) (display "done"))
            ((fast-prime? initial-number 5)
             (timed-prime-test initial-number)
                  (search-for-primes (+ initial-number 2) (- count 1)))
            (else (search-for-primes (+ initial-number 2) count)))))

#|
médias de 5 execuções, respectivamente:
1000    - 3.0
10000   - 5.47  - ratio = 1.82
100000  - 14.07 - ratio = 2.57
1000000 - 37.87 - ratio = 2.69

Os resultados ficaram um pouco abaixo do esperado.
|#

;; Exercise 1.23
#|
anterior:
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

nova versão:
(define (next n)
  (if (= n 2)
      3
      (+ n 2)))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

médias de 5 execuções, respectivamente:
1000    - 2.47  - ratio = 1.21
10000   - 4.47  - ratio = 1.22
100000  - 11.07 - ratio = 1.27
1000000 - 30.87 - ratio = 1.23

Como podemos observar, o algoritmo teve uma melhoria razoável,
porém, bem abaixo dos 200% esperado. Podemos justificar isso
com o fato de termos adicionado mais computações como mais uma
chamada de função, mais um if e predicado.
|#

;; Exercise 1.24
#|
antigo:
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

nova versão:
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

médias de 5 execuções, respectivamente:
1000    - 2.47
10000   - 4.47  - ratio = 1.22
100000  - 11.07 - ratio = 1.27
1000000 - 30.87 - ratio = 1.23
|#
;; Exercise 1.25
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

(define (new-expmod base exp m)
  (remainder (fast-expti base exp) m))
#|
O algoritmo da Alyssa P. Hacker funciona, mas ao calcular o exponencial
primeiro, podemos gerar números muito grandes que usam algorimtos mais
robustos para calcular multiplicações e o resto. O nosso algorimto original
quebra o problema em partes menores do mesmo tamanho tornando-o mais fácil
de lidar.
|#
;; Exercise 1.26
#|
Como o interpretador usa applicative-order evaluation os dois expmod são avaliados
antes da multiplicação ser feita. A complexidade se torna Θ(log2^n)= Θ(nlog2)= Θ(n).
|#