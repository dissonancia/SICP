#!/usr/local/bin/guile -s!#

(define (pascal row col)
  (cond ((= row 1) 1)
	((or (= col 1) (= col row)) 1)
	(else (+ (pascal (- row 1) (- col 1))
		 (pascal (- row 1) col)))))

;; it's easy to reasoning if the Pascal’s triangle
;; is in this form:
;; 1
;; 1 1
;; 1 2 1
;; 1 3 3 1
;; 1 4 6 4 1
;;   . . .
