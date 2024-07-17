extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
const speed = 100.0
var facing = "down"
var animation_dir = Vector2.ZERO

func _physics_process(delta):
	movement(speed)
	
	
func movement(speed):
	# input_direction is given as Vector2 (x, y) both values either -1, 0, or 1
	# when two directions are pressed (0.707107, 0.707107)
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	animate(input_direction)
	move_and_slide()
	
func animate(input_direction):
	### determine initial direction for the animation
	# Just realized this won't work if initial input is not cardinal
	if input_direction == Vector2 (1,0):
		animation_dir = Vector2 (1,0)
		facing = "right"
	if input_direction == Vector2 (-1,0):
		animation_dir = Vector2 (-1,0)
		facing = "left"
	if input_direction == Vector2 (0,-1):
		animation_dir = Vector2 (0,-1)
		facing = "up"
	if input_direction == Vector2 (0,1):
		animation_dir = Vector2 (0,1)
		facing = "down"
		
		
	### Determine which animation to play while moving
	# check if direction is changed (up to right) or just modified (up and right)
	# deviation is used to find the degrees between movement direction and initial direction to dictate the animation
	var deviation = abs(input_direction.angle_to(animation_dir))
	if deviation < PI/3 and input_direction != Vector2.ZERO: # 50 allows the initial direction animation to play on diagonals
		if facing == "right":
			animator.flip_h = false
			animator.play("move_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("move_side")
		elif facing == "up" or facing == "down":
			animator.play("move_" + facing)
			
	#play idle animations in correct direction
	if input_direction == Vector2.ZERO:
		if facing == "right":
			animator.flip_h = false
			animator.play("idle_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("idle_side")
		elif facing == "up" or facing == "down":
			animator.play("idle_" + facing)
