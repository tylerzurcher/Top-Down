extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
@onready var player = %Player
const speed = 30.0
var state = "idle"
var facing = ""
var animation_dir = Vector2.ZERO

func _physics_process(delta):
	movement(speed, delta)
	
	
func movement(speed, delta):
	#position += (player.position - position).normalized() * speed * delta
	velocity = (player.get_global_position() - position).normalized() * speed
	print(velocity.normalized(), facing)
	move_and_slide()
	animate(velocity)
	
func animate(velocity):
	### determine initial direction for the animation
	# need to find a way to figure out what direction it's mostly going in
	# I think deviation will play a large role in this
	if velocity.x > 0:
		animation_dir = Vector2 (1,0)
		facing = "right"
	if velocity.x < 0:
		animation_dir = Vector2 (-1,0)
		facing = "left"
	if velocity.y < 0:
		animation_dir = Vector2 (0,-1)
		facing = "up"
	if velocity.y > 0:
		animation_dir = Vector2 (0,1)
		facing = "down"
		
		
	### Determine which animation to play while moving
	# check if direction is changed (up to right) or just modified (up and right)
	# deviation is used to find the degrees between movement direction and initial direction to dictate the animation
	var deviation = abs(velocity.angle_to(animation_dir))
	if deviation < PI/3 and velocity != Vector2.ZERO: # 50 allows the initial direction animation to play on diagonals
		if facing == "right":
			animator.flip_h = false
			animator.play("move_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("move_side")
		elif facing == "up" or facing == "down":
			animator.play("move_" + facing)
			
	#play idle animations in correct direction
	if velocity == Vector2.ZERO:
		if facing == "right":
			animator.flip_h = false
			animator.play("idle_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("idle_side")
		elif facing == "up" or facing == "down":
			animator.play("idle_" + facing)
