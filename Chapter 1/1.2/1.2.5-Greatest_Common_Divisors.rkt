#lang sicp
;; 1.2.5 Greatest Common Divisors

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; Exercise 1.20
;; Normal-order evaluation
#|
1.(gcd 206 40)

2.(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

3.(gcd 40 (remainder 206 40))

4.(if (= (remainder 206 40) 0) ; 1 remainder evaluated
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

5.(if (= 6 0)
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

6.(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

7.(if (= (remainder 40 (remainder 206 40)) 0) ; 2 remainder evaluated
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

8.(if (= 4 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

9.(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

10.(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; 4 remainder evaluated
     (remainder 40 (remainder 206 40))
     (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
          (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

11.(if (= 2 0)
     (remainder 40 (remainder 206 40))
     (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
          (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

12.(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
        (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

13.(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; 7 remainder evaluated
     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
          (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
                     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

14.(if (= 0 0)
     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
          (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
                     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

15.(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; 4 remainder evaluated

16.2

usando o normal-order evaluation, remainder foi chamado 1+2+4+7+4 = 18 vezes
|#
;; Applicative-order evaluation
#|
1.(gcd 206 40)

2.(if (= 40 0)
    206
    (gcd 40 (remainder 206 40))) ; 1 remainder evaluated

3.(if (= 40 0)
    206
    (gcd 40 6))

4.(gcd 40 6)

5.(if (= 6 0)
    40
    (gcd 6 (remainder 40 6))) ; 1 remainder evaluated

6.(if (= 6 0)
    40
    (gcd 6 4))

7.(gcd 6 4)

8.(if (= 4 0)
    6
    (gcd 4 (remainder 6 4))) ; 1 remainder evaluated

9.(if (= 4 0)
    6
    (gcd 4 2))

10.(gcd 4 2)

11.(if (= 2 0)
     4
     (gcd 2 (remainder 4 2))) ; 1 remainder evaluated

12.(if (= 2 0)
     4
     (gcd 2 0))

13.(gcd 2 0)

14.(if (= 0 0)
     2
     (gcd 0 (remainder 2 0)))

15.2

usando o applicative-order evaluation, remainder foi chamado 1+1+1+1 = 4 vezes
|#