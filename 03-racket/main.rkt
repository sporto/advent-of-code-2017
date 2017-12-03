#lang Racket

(define (distance-for-step steps_in_leg current_step) (
  if (< current_step (/ steps_in_leg 2))
    (- (- steps_in_leg 1) current_step) current_step))

(define (check-step target-num current-number steps-in-leg leg-section current-step) (
  if (= target-num current-number)
        (distance-for-step steps-in-leg current-step)
        (if (< current-step steps-in-leg) 
            (check-step target-num (+ current-number 1) steps-in-leg leg-section (+ current-step 1))
            (if (= leg-section 1)
                (walk-leg-section target-num (+ current-number 1) steps-in-leg 2)
                (walk-leg target-num (+ current-number 1) (+ steps-in-leg 1))
            )
        )
    ))

(define (walk-leg-section target-num current-number steps-in-leg leg-section)
  (check-step target-num current-number steps-in-leg leg-section 1))

(define (walk-leg target-num current-number steps-in-leg) 
  (walk-leg-section target-num current-number steps-in-leg 1))

; (walk-leg 23 2 1)  ; 2
;(walk-leg 1024 2 1)  ; 31
(walk-leg 368078 2 1)  ; 371

; (distance-for-step 5 1)