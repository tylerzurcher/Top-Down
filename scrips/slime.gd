extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
@onready var player = %Player
@onready var incoming = $"Detection Radius"
const speed = 50.0
var state = "idle"
var facing = ""
var animation_dir = Vector2.ZERO
var pursuit = false

func _physics_process(delta):
	if pursuit == true and animator.frame in [2,3,4]:
		movement(speed, delta)
	print(animator.frame, animator.animation_looped)
	animate()
	
func movement(speed, delta):
	#position += (player.position - position).normalized() * speed * delta
	velocity = (player.get_global_position() - position).normalized() * speed
	#print(velocity.normalized().angle(), facing)
	move_and_slide()
	
func animate():
	
	#velocity = velocity.normalized()
	### determine initial direction for the animation
	# check to see which direction velocity is mostly towards
	if abs(velocity.angle_to(Vector2.RIGHT)) < PI/4:
		animation_dir = Vector2 (1,0)
		facing = "right"
	if abs(velocity.angle_to(Vector2.LEFT)) < PI/4:
		animation_dir = Vector2 (-1,0)
		facing = "left"
	if abs(velocity.angle_to(Vector2.UP)) < PI/4:
		animation_dir = Vector2 (0,-1)
		facing = "up"
	if abs(velocity.angle_to(Vector2.DOWN)) < PI/4:
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



func _on_detection_radius_body_entered(body):
	print('Player Found', pursuit)
	pursuit = true
	pass # Replace with function body.
