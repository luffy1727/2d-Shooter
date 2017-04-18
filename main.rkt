#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define player (bitmap "character_sprite.png"))
(define enemy (bitmap "enemy.jpg"))

(define foo '(500 20))


(define (character t) ;t =WorldState
  (place-image player
               (car t)
               (cdr t)
               (empty-scene 500 500)))


(define (make-projectile proj-image x y scene)
  (place-image proj-image x y scene)
  )

(define (world t)
  (place-image player
               (car t)
               (cdr t)
               (make-projectile enemy (projectile-x foo) (projectile-y foo) (empty-scene 600 600)))  
  )

;;
(define (projectile-x foo)
  (car foo)
  )

(define (projectile-y foo)
  (cadr foo)
  )






;; takes a world moves the projectiles
(define (the-tick-handler)
  (if (> (projectile-x foo) 0) (- (projectile-x foo) 1)
  (projectile-x foo))
  )



(define (change w a-key)
  (cond
    [(key=? a-key "left")  (cons (-(car w) 5) (cdr w))] 
    [(key=? a-key "right") (cons (+ 5 (car w)) (cdr w))]
    [(= (string-length a-key) 1) w] 
    [else w]))

(big-bang '(20 . 500)
          (on-tick the-tick-handler)
          (to-draw world)
          (on-key change))
