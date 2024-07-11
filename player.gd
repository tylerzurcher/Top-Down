extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum { stateIdle, stateWalking}
var state = stateIdle

func _physics_process(delta):

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var y_direction = Input.get_axis("move_up", "move_down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	var direction = Vector2 (x_direction, y_direction)
	
	print(direction)
	### Need to figure out how to make run animation play only when there is input
	# Play running animations
	if y_direction > 0:
		animator.play("run_down")
	elif y_direction < 0:
		animator.play("run_up")
	elif x_direction > 0:
		animator.flip_h = false
		animator.play("run_side")
	elif x_direction < 0:
		animator.flip_h = true
		animator.play("run_side")
	
	### Need to figure out how to make idle animation play when there is no input
	# Play idle animations
	if x_direction or y_direction == 0:
		if direction.y > 0:
			animator.play("idle_down")
		elif direction.y < 0:
			animator.play("idle_up")
		elif direction.x > 0:
			animator.flip_h = false
			animator.play("idle_side")
		elif direction.x < 0:
			animator.flip_h = true
			animator.play("idle_side")
		

	move_and_slide()
