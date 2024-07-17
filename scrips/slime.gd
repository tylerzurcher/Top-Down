extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
@onready var player = %Player
const speed = 50.0
var state = "idle"

func _physics_process(delta):
	movement(speed)
	animate()
	
	
func movement(speed):
	print(player.get_velocity())
	move_and_slide()
	
func animate():
	if Input.get_vector("left", "right", "up", "down") == Vector2.ZERO:
		state = "idle"
	else:
		state = "move"
