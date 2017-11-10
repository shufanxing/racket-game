;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname change-structure-world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; A Spcaeship is a Posn;

;; A Bullet is a posn

;; A ListOfPosn(LoP) is one of
;; -empty
;; -(cons posn lop)
;; INTERP: a list of posns; 


;; Deconstructor Template
;; lob-fn: LoB -> ???
#; (define (lob-fn lob)
     (cond
       [(empty? lob)...]
       [(cons? lob)...(posn-fn (first lob))...
                    ...(lob-fn (rest lob))...]))

;; A SpaceshipBullets(SB) is a LoP
;; INTERP: the bullets fired by the spcaeship
;; WHERE: the list can only have up to 3 bullets

(define SPACE " ")
(define UP "up")
(define DOWN "down")
(define LEFT "left")
(define RIGHT "right")

;; A Direction is one of
;; -SAPCE
;; INTERP: the fire control of spaceship
;; -UP
;; -DOWN
;; -LEFT
;; -RIGHT
;; INTERP: represents the moving direction of objects on the canvas


;; Deconstructor Template
;; direction-fn: Direction -> ???
#; (define (direction-fn direction)
     (cond
       [(string=? SPACE direction)...]
       [(string=? UP direction)...]
       [(string=? DOWN direction)...]
       [(string=? RIGHT direction)...]
       [(string=? LEFT direction)...]))



;; An Invader is a Posn

;; An GroupOfInvaders(GoI) is one of
;; - empty
;; -(cons invader goi)
;; INTERP: represents a list of invaders as a group

;; Deconstructor
;; goi-fn: GOI -> ???
#; (define (goi-fn goi)
     (cond
       [(empty? goi)...]
       [(cons? goi)...(posn-fn (first goi))...
                   ...(goi-fn (rest goi))]))

;; An InvaderBullets(IB) is a LoP
;; INTERP: the bullets fired by the invaders
;; WHERE: the list can only have up to 10 bullets 


;; A Score is a NonNegInteger
;; INTERP: represents the score player get by killing invaders
;;         killing each invader will make 3 points
;; WHERE: 0<=Score<=108;

;; A Tick is a NonNegInteger
;; INTERP: represents the total number of ticks after after the on-tick
;;         function started

;; A Life is a NonNegInteger
;; INTERP: the life/lives of spaceship
;; WHERE: 0<=life<=3

(define-struct world (dir spaceship sb invaders ib score life tick))
;; A World is (make-world Spaceship SB GOI IB Score Life Tick)
;; INTERP: represents a world with spaceship, invaders, spaceship's bullets
;;         invaders' bullets, score, life and tick number
     
;; Deconstructor Template
;; world-fn : World -> ???
#; (define (world-fn world)
     ...(direction-fn (world-dir world))...
     ...(spaceship-fn (world-spaceship world))...
     ...(goi-fn (world-invaders world))...
     ...(lob-fn (world-sb world))...
     ...(lob-fn (world-ib world))...
     ...(world-score world)...
     ...(world-life world)...
     ...(world-tick world)...)

(define WIDTH 520) ;; scene width in pixels
(define HEIGHT 600) ;; scene height in pixels
(define SPEED-SHIP 20)
(define SPEED-BU 25)
(define SPEED-IN 12.5)
(define N 80)
(define MAX-LIVES 3)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define INVADER-IMG (square 30 'solid 'red))
(define SPACESHIP-IMG (rectangle 60 20 'solid 'black))
(define SBULLET-IMG (circle 2 'solid 'black))
(define IBULLET-IMG (circle 2 'solid 'red))
(define MAX-SB 3)
(define MAX-IB 10)
(define EMPTY empty)
(define SPACESHIP (make-posn 40 560))
(define SPACESHIP1 (make-posn 160 560))
(define INVADERS
  (list (make-posn 100 180)
        (make-posn 140 180)
        (make-posn 180 180)
        (make-posn 220 180)
        (make-posn 260 180)
        (make-posn 300 180)
        (make-posn 340 180)
        (make-posn 380 180)
        (make-posn 420 180)
        (make-posn 100 140)
        (make-posn 140 140)
        (make-posn 180 140)
        (make-posn 220 140)
        (make-posn 260 140)
        (make-posn 300 140)
        (make-posn 340 140)
        (make-posn 380 140)
        (make-posn 420 140)
        (make-posn 100 100)
        (make-posn 140 100)
        (make-posn 180 100)
        (make-posn 220 100)
        (make-posn 260 100)
        (make-posn 300 100)
        (make-posn 340 100)
        (make-posn 380 100)
        (make-posn 420 100)
        (make-posn 100 60)
        (make-posn 140 60)
        (make-posn 180 60)
        (make-posn 220 60)
        (make-posn 260 60)
        (make-posn 300 60)
        (make-posn 340 60)
        (make-posn 380 60)
        (make-posn 420 60)))



(define WORLD-INIT (make-world RIGHT SPACESHIP EMPTY INVADERS EMPTY 0 3 0))

(define INVADERS1 (list (make-posn 160 400)
                        (make-posn 300 300)
                        (make-posn 260 200)))
(define IB (list (make-posn 300 200) (make-posn 400 100) (make-posn 200 200)))
(define SB (list (make-posn 200 100) (make-posn 200 300) (make-posn 400 200)))

(define WORLD-1 (make-world RIGHT SPACESHIP1 SB INVADERS1 IB 30 1 100))

;;;; Signature
;; world-draw: World -> Image

;;;; Purpose
;; GIVEN: a world
;; RETURN: an image representing the given world

;;;; Function Definition
(define (world-draw w)
  (draw-score (world-score w)
              (draw-life (world-life w)
                         (draw-sb (world-sb w)
                                  (draw-invaders (world-invaders w)
                                        (draw-ib (world-ib w)
                                                 (draw-spaceship
                                                  (world-spaceship w)
                                                  BACKGROUND)))))))

;;;; Signature
;; draw-spaceship: Spaceship Image -> Image

;;;; Purpose
;; GIVEN: a spaceship and an image
;; RETURN: a new image with the spaceship drawn on the given image

;;;; Function Definition
(define (draw-spaceship spaceship img)
  (place-image SPACESHIP-IMG
               (posn-x spaceship)
               (posn-y spaceship)
               img))

;;;; Signature
;; draw-sb: SB Image -> Image

;;;; Purpose
;; GIVEN: a list of spaceship bullets and an image
;; RETURN: a new Image that draws spaceship bullets on the given image 

;;;; Function Definition
(define (draw-sb sb img)
  (cond
    [(empty? sb) img]
    [(cons? sb) (place-image
                 SBULLET-IMG
                 (posn-x (first sb))
                 (posn-y (first sb))
                 (draw-sb (rest sb) img))]))

;;;; Signature
;; draw-ib: IB IMAGE -> IMAGE

;;;; Purpose
;; GIVEN: the invaders' bullets information and an image
;; RETURN: the new image with invaders' bullets drawn on the given image

;;;; Function Definition
(define (draw-ib ib img)
  (cond
    [(empty? ib) img]
    [(cons? ib) (place-image
                 IBULLET-IMG
                 (posn-x (first ib))
                 (posn-y (first ib))
                 (draw-ib (rest ib) img))]))

;;;; Signature
;; draw-life: NonNegInteger Image -> Image

;;;; Purpose
;; GIVEN: a NonNegInteger and an image
;; RETURN: a new imgae with the number shown at the right bottom of the image

;;;; Function Definition
(define (draw-life num img)
  (place-image (text (string-append "Life: " (number->string num)) 20 "red")
               480 
               580
              img))

;;;; Signature
;; draw-group: GoI Image -> Image

;;;; Purpose
;; GIVEN: a group of invaders and an image
;; RETURN: a new image with group of invaders drawn on the given image

;;;; Function Defition
(define (draw-invaders goi img)
  (cond
    [(empty? goi) img]
    [(cons? goi) (place-image INVADER-IMG
                                   (posn-x (first goi))
                                   (posn-y (first goi))
                                   (draw-invaders (rest goi) img))]))

;;;; Signature
;; draw-score: Score Image -> Image

;;;; Purpose
;; GIVEN: a score and an image
;; RETURN: a new image with the score drawn on the top middle of the image

;;;; Function Definition
(define (draw-score num img)
  (place-image (text (string-append "Score: "(number->string num)) 20 "black")
               250
               20
               img))
;;;; Test
(world-draw WORLD-INIT)
(world-draw WORLD-1)


;;;; Signature
;; world-step: World -> World
;;;; Purpose
;; GIVEN: a current world
;; RETURN: the next world

;;;; Function Definition
(define (world-step w)
  (make-world
   (world-dir w)
   (move-spaceship w)
   (move-sb w)
   (move-invaders w)
   (move-ib w)
   (update-score w)
   (update-life w)
   (+ 1 (world-tick w))))



;                                                                                                    
;                                                                                ;                   
;                                                                                ;         ;         
;                                                                                ;                   
;  ;;;;;;   ;;;   ;   ;   ;;;           ;;;   ;;;;   ;;;;    ;;;    ;;;    ;;;   ; ;;    ;;;   ;;;;  
;  ;  ;  ; ;; ;;  ;   ;  ;;  ;         ;   ;  ;; ;;      ;  ;;  ;  ;;  ;  ;   ;  ;;  ;     ;   ;; ;; 
;  ;  ;  ; ;   ;   ; ;   ;   ;;        ;      ;   ;      ;  ;      ;   ;; ;      ;   ;     ;   ;   ; 
;  ;  ;  ; ;   ;   ; ;   ;;;;;; ;;;;;;  ;;;   ;   ;   ;;;;  ;      ;;;;;;  ;;;   ;   ;     ;   ;   ; 
;  ;  ;  ; ;   ;   ; ;   ;                 ;  ;   ;  ;   ;  ;      ;          ;  ;   ;     ;   ;   ; 
;  ;  ;  ; ;; ;;    ;    ;             ;   ;  ;; ;;  ;   ;  ;;     ;      ;   ;  ;   ;     ;   ;; ;; 
;  ;  ;  ;  ;;;     ;     ;;;;          ;;;   ;;;;    ;;;;   ;;;;   ;;;;   ;;;   ;   ;   ;;;;; ;;;;  
;                                             ;                                                ;     
;                                             ;                                                ;     
;                                             ;                                                ;     


;; move-spaceship: World -> Spaceship
(define (move-spaceship w)
  (cond
    [(spaceship-hit? (world-spaceship w) (world-ib w)) SPACESHIP]
    [(out? (world-spaceship w)) (ship-next-loc (world-spaceship w) (world-dir w)) ]
    [else (ship-next-loc (world-spaceship w) (world-dir w))]))
    
;; ship-next-loc: World -> Spaceship
(define (ship-next-loc posn dir)
  (cond
    [(string=? UP dir) posn]
    [(string=? DOWN dir) posn]
    [(string=? SPACE dir) posn]
    [(string=? RIGHT dir) (make-posn (+ (posn-x posn)
                                        SPEED-SHIP)
                                     (posn-y posn))]
    [(string=? LEFT dir) (make-posn (- (posn-x posn)
                                        SPEED-SHIP)
                                     (posn-y posn))]))

;; spaceship-hit?: Spaceship IB -> Boolean
(define (spaceship-hit? loc ib)
  (cond
    [(empty? ib) #false]
    [(cons? ib) (or (and (<= (- (posn-x loc) 30)
                             (posn-x (first ib))
                             (+ (posn-x loc) 30))
                         (<= (- (posn-y loc) 10)
                             (posn-y (first ib))
                             (+ (posn-y loc) 10)))
                    (spaceship-hit? loc (rest ib)))]))

;; out? : Posn -> Boolean
(define (out? posn)
  (or (or (> (posn-x posn) WIDTH)
          (< (posn-x posn) 0))
      (or (> (posn-y posn) HEIGHT)
          (< (posn-y posn) 0))))




;                                                   
;                                             ;     
;                                             ;     
;                                             ;     
;  ;;;;;;   ;;;   ;   ;   ;;;           ;;;   ;;;;  
;  ;  ;  ; ;; ;;  ;   ;  ;;  ;         ;   ;  ;; ;; 
;  ;  ;  ; ;   ;   ; ;   ;   ;;        ;      ;   ; 
;  ;  ;  ; ;   ;   ; ;   ;;;;;; ;;;;;;  ;;;   ;   ; 
;  ;  ;  ; ;   ;   ; ;   ;                 ;  ;   ; 
;  ;  ;  ; ;; ;;    ;    ;             ;   ;  ;; ;; 
;  ;  ;  ;  ;;;     ;     ;;;;          ;;;   ;;;;  
;                                                   
;                                                   
;                                                   

;; move-sb: World -> SB

(define (move-sb w)
  (bullets-move-up
   (fire-sb
    (remove-out-hit w))
   SPEED-BU))

;; fire-sb: World -> SB
(define (fire-sb w)
  (cond
    [(string=? (world-dir w) SPACE)
     (cond
       [(>= (p-number (world-sb w)) MAX-SB) (world-sb w)]
       [else
         (cons (world-spaceship w)(world-sb w))])]
    [else (world-sb w)]))

;; p-number : LoP -> NonNegInteger
(define (p-number lop)
  (cond
    [(empty? lop) 0]
    [(cons? lop) (+ 1
                    (p-number (rest lop)))]))


;;(define-struct world (dir spaceship sb invaders ib score life tick))
;; bullets-move-up: World -> World
(define (bullets-move-up sb speed)
  (cond
    [(empty? sb) sb]
    [(cons? sb) (cons (bu-move-up (first sb) speed)
                          (bullets-move-up (rest sb) speed))]))


;; bu-move-up: Bullet NonNegReal -> Bullet
(define (bu-move-up posn speed)
  (make-posn
   (posn-x posn)
   (- (posn-y posn)
      speed)))

;; remove-out-hit: World -> World
(define (remove-out-hit w)
  (make-world (world-dir w)
              (world-spaceship w)
              (remove-sb (world-sb w) (world-invaders w))
              (remove-invaders (world-sb w) (world-invaders w))
              (remove-ib (world-ib w))
              (world-score w)
              (world-life w)
              (world-tick w)))

;; remove-sb: SB GOI-> SB
(define (remove-sb sb invaders)
  (remove-p-out (remove-sb-hit sb invaders)))

;; remove-p-out: LoP -> LoP
(define (remove-p-out lop)
  (cond
    [(empty? lop) empty]
    [(cons? lop) (if (out? (first lop))
                    (remove-p-out (rest lop))
                    (cons (first lop)
                          (remove-p-out (rest lop))))]))

;; remove-sb-hit: SB GOI -> SB
(define (remove-sb-hit sb invaders)
  (cond
    [(empty? sb) empty]
    [(cons? sb) (if (invader-hit? (first sb) invaders)
                    (rest sb)
                    (cons (first sb)
                          (remove-sb (rest sb) invaders)))]))

;; invader-hit?: Posn LoP -> Boolean
(define (invader-hit? posn invaders)
  (cond
    [(empty? invaders) #false]
    [(cons? invaders) (or (invader-range? posn (first invaders))
                          (invader-hit? posn (rest invaders)))]))
;; invader-range?: Posn Posn -> Boolean
(define (invader-range? p1 p2)
  (and (>= (+ (posn-x p2) 15)
           (posn-x p1)
           (- (posn-x p2) 15))
       (>= (+ (posn-y p2) 15)
           (posn-y p1)
           (- (posn-y p2) 15))))


;;remove-invaders: SB GOI -> GOI
(define (remove-invaders sb invaders)
  (cond
    [(empty? sb) invaders]
    [(cons? sb) (if (invader-hit? (first sb) invaders)
                    (remove (rest sb) (remove-hit-invaders (first sb) invaders))
                    (remove-invaders (rest sb) invaders))]))
;; remove-hit-invaders: Posn GOI -> GOI
(define (remove-hit-invaders posn invaders)
  (cond
    [(empty? invaders) invaders]
    [(cons? invaders) (if (invader-range? posn (first invaders))
                          (rest invaders)
                          (cons (first invaders)
                                (remove-hit-invaders posn (rest invaders))))]))


;;remove-ib: IB -> IB
(define (remove-ib ib)
  (cond
    [(empty? ib) ib]
    [(cons? ib) (if (out? (first ib))
                    (remove-ib (rest ib))
                    (cons (first ib)(remove-ib (rest ib))))]))


;                                                                                                          
;                                                                                                          
;                                              ;                                 ;                         
;                                              ;                                 ;                         
;                                                                                ;                         
;   ;;;;;;   ;;;;   ;    ;   ;;;;            ;;;    ; ;;;   ;    ;    ;;;    ;;; ;   ;;;;    ;;;;;   ;;;;  
;   ;  ;  ; ;;  ;;  ;    ;   ;  ;;             ;    ;;   ;  ;    ;   ;   ;   ;  ;;   ;  ;;   ;;     ;    ; 
;   ;  ;  ; ;    ;   ;  ;   ;    ;             ;    ;    ;   ;  ;        ;  ;    ;  ;    ;   ;      ;      
;   ;  ;  ; ;    ;   ;  ;   ;;;;;;  ;;;;;;;    ;    ;    ;   ;  ;    ;;;;;  ;    ;  ;;;;;;   ;      ;;;    
;   ;  ;  ; ;    ;   ;  ;   ;                  ;    ;    ;   ;  ;   ;    ;  ;    ;  ;        ;         ;;; 
;   ;  ;  ; ;    ;    ;;    ;                  ;    ;    ;    ;;    ;    ;  ;    ;  ;        ;           ; 
;   ;  ;  ; ;;  ;;    ;;     ;                 ;    ;    ;    ;;    ;   ;;   ;  ;;   ;       ;      ;    ; 
;   ;  ;  ;  ;;;;     ;;     ;;;;;          ;;;;;;; ;    ;    ;;     ;;; ;   ;;; ;   ;;;;;   ;       ;;;;  
;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          
;; move-invaders: World -> GOI
(define (move-invaders w)
  (if (= (remainder (world-tick (remove-out-hit w)) N) 0)
      (move-down (world-invaders (remove-out-hit w)) SPEED-IN)
      (world-invaders (remove-out-hit w))))
;; move-down: LoP NonNegInteger -> LoP
(define (move-down lop speed)
  (cond
    [(empty? lop) lop]
    [(cons? lop) (cons (p-move-down (first lop) speed)
                       (move-down (rest lop) speed))]))
;; p-move-down: Posn NonNegInteger-> Posn
(define (p-move-down posn speed)
  (make-posn
   (posn-x posn)
   (+ (posn-y posn)
      speed)))


;                                                          
;                                                          
;                                              ;    ;      
;                                              ;    ;      
;                                                   ;      
;   ;;;;;;   ;;;;   ;    ;   ;;;;            ;;;    ; ;;;  
;   ;  ;  ; ;;  ;;  ;    ;   ;  ;;             ;    ;;  ;  
;   ;  ;  ; ;    ;   ;  ;   ;    ;             ;    ;    ; 
;   ;  ;  ; ;    ;   ;  ;   ;;;;;;  ;;;;;;;    ;    ;    ; 
;   ;  ;  ; ;    ;   ;  ;   ;                  ;    ;    ; 
;   ;  ;  ; ;    ;    ;;    ;                  ;    ;    ; 
;   ;  ;  ; ;;  ;;    ;;     ;                 ;    ;;  ;  
;   ;  ;  ;  ;;;;     ;;     ;;;;;          ;;;;;;; ; ;;;  
;                                                          
;                                                          
;                                                          
;                                                          
;; move-ib: World -> IB
(define (move-ib w)
  (move-down (invaders-fire (world-ib (remove-out-hit w))
                            (world-invaders (remove-out-hit w)))
             SPEED-BU))
;; invaders-fire: World -> IB
(define (invaders-fire ib invaders)
  (cond
    [(>= (p-number ib) MAX-IB) ib]
    [else (if (>= (p-number invaders) 1)
              (add-ibullet
               invaders
               ib
               (random (p-number invaders)))
              ib)]))


;;;; Signature
;; add-ibullets: GOI IB NonNeginteger -> IB

;;;; Purpose
;; GIVEN: a group of invaders , an invaders' bullests list and
;;        a random NonNegInteger (which is not greater than the total
;;        number of invaders)
;; RETURN: a randomly selected member (represented with a posn)
;;         of the given invaders

;;;; Function Defintion
(define (add-ibullet goi ib num)
  (cond
    [(= num 0) ib]
    [else (cond
           [(empty? goi) ib]
           [(cons? goi) (if (= num 1)
                            (cons (first goi) ib)
                            (add-ibullet (rest goi) ib (- num 1)))])]))


;; update-score: World -> Score
(define (update-score w)
  (* 3
     (- 36
        (p-number (world-invaders w)))))
;; update-life: World -> Life
(define (update-life w)
  (cond
    [(spaceship-hit? (world-spaceship w) (world-ib w)) (- (world-life w) 1)]
    [else (world-life w)]))

;;end-game? : World -> Boolean

(define (end-game? w)
  (or (= (world-life w) 0)
      (= (world-score w) 108)
      (invaders-too-low? w)))
;; 
(define (invaders-too-low? w)
  (cond
    [(empty? (world-invaders w)) #false]
  
    [else (>= (posn-y (lowest-invader
                       (first (world-invaders w))
                       (rest (world-invaders w))))
              520)]))

(define (lowest-invader posn goi)
  (cond
    [(empty? goi) posn]
    [(cons? goi) (if (lower posn (first goi))
                     (lowest-invader posn (rest goi))
                     (lowest-invader (first goi) (rest goi)))]))

(define (lower p1 p2)
  (> (posn-y p1) (posn-y p2)))

  
(define (key-handler w ke)
  (cond
    [(or (key=? ke "up")
         (key=? ke "down")
         (key=? ke "left")
         (key=? ke "right")
         (key=? ke " "))
     (make-world ke
                 (world-spaceship w)
                 (world-sb w)
                 (world-invaders w)
                 (world-ib w)
                 (world-score w)
                 (world-life w)
                 (world-tick w))]
           
    [else w]))
(big-bang WORLD-INIT
          (on-tick world-step 0.3)
          (to-draw world-draw)
          (stop-when end-game?)
          (on-key key-handler))