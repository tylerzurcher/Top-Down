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
		
	# check if direction is changed (up to right) or just modified (up and right)
	# deviation is used to find the degrees between movement direction and initial direction to dictate the animation
	var deviation = rad_to_deg(abs(input_direction.angle_to(animation_dir)))
	if deviation < 50: # 50 allows the initial direction animation to play on diagonals
		if facing == "right":
			animator.flip_h = false
			animator.play("move_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("move_side")
		elif facing == "up" or facing == "down":
			animator.play("move_" + facing)
	
	print(animation_dir, facing, input_direction)
	print(input_direction == Vector2.ZERO, facing == "right")
	#play idle animations in correct direction
	if input_direction == Vector2 (0,0):
		if facing == "right":
			animator.flip_h = false
			animator.play("idle_side")
		if facing == "left":
			animator.flip_h = true
			animator.play("idle_side")
		elif facing == "up" or facing == "down":
			animator.play("idle_" + facing)
	
	
	
	
	#check starting direction then check deviation
	#if input_direction.x > 0:
		#if abs(Vector2.RIGHT.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
			#facing = "right"
			#print(facing)
	#if input_direction.x < 0:
		#if abs(Vector2.LEFT.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
			#facing = "left"
			#print(facing)
	#if input_direction.y > 0:
		#if abs(Vector2.DOWN.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
			#facing = "down"
			#print(facing)
	
	
	### This is the checks for the PI/3 deviation from the cardinal directions
	#if abs(Vector2.RIGHT.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
		#facing = "right"
		#print(facing)
	#if abs(Vector2.LEFT.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
		#facing = "left"
		#print(facing)
	#if abs(Vector2.UP.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
		#facing = "up"
		#print(facing)
	#if abs(Vector2.DOWN.angle_to(velocity)) < PI * 0.3 and input_direction != Vector2.ZERO:
		#facing = "down"
		#print(facing)
	
	#print(velocity)
	#print(input_direction)
	#print(Vector2.RIGHT)
	
	### if absolute value of distance from vector TB to vector direction converted to radians is < pi/3
		### I think TB is the cardinal directions and direction is the way the character is going
	### if abs(TB.direction_to_vector(direction).angle_to(velocity)) < PI * .3:

	
	
	### works on everything but diagonals, possibly need to code specifically for diagonals
	#var input = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	#print(input)
	#if input.y < 0:
		#animator.play("move_down")
		#velocity.y = speed
	#elif Input.is_action_just_released("move_down"):
		#animator.play("idle_down")
		#velocity.y = 0
	#if input.y > 0:
		#animator.play("move_up")
		#velocity.y = -speed
	#elif Input.is_action_just_released("move_up"):
		#animator.play("idle_up")
		#velocity.y = 0
	#if input.x > 0:
		#animator.flip_h = false
		#animator.play("move_side")
		#velocity.x = speed
	#elif Input.is_action_just_released("move_right"):
		#animator.play("idle_side")
		#velocity.x = 0
	#if input.x < 0:
		#animator.flip_h = true
		#animator.play("move_side")
		#velocity.x = -speed
	#elif Input.is_action_just_released("move_left"):
		#animator.play("idle_side")
		#velocity.x = 0
	


	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var x_direction = Input.get_axis("move_left", "move_right")
	#if x_direction:
		#velocity.x = x_direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#
	#var y_direction = Input.get_axis("move_up", "move_down")
	#if y_direction:
		#velocity.y = y_direction * speed
	#else:
		#velocity.y = move_toward(velocity.y, 0, speed)
		#
	#
	#print(" x_direction:", x_direction, " y_direction:", y_direction)
	#### Need to figure out how to make idle animation play when there is no input
	##Play idle animations
	#if x_direction and y_direction == 0:
		#if y_direction > 0:
			#animator.play("idle_down")
		#elif y_direction < 0:
			#animator.play("idle_up")
		#elif x_direction > 0:
			#animator.flip_h = false
			#animator.play("idle_side")
		#elif x_direction < 0:
			#animator.flip_h = true
			#animator.play("idle_side")
	#
	#print(Input.is_action_pressed("move_right"))
	#
	#var movement = ["move_up", "move_down", "move_side"]
	##### Need to figure out how to make move animation play only when there is input
	## Play running animations
#
	#if y_direction == 1 and Input.is_action_pressed("move_down"):
		#animator.play("move_down")
	#elif y_direction == -1:
		#animator.play("move_up")
	#elif x_direction == 1:
		#animator.flip_h = false
		#animator.play("move_side")
	#elif x_direction == -1:
		#animator.flip_h = true
		#animator.play("move_side")
	

