extends CharacterBody3D

var jumpHeight = 20
var timeToJumpPeak = 20
var speed = 15
@onready var gravity = int(2 * jumpHeight / (timeToJumpPeak ^ 2))
@onready var jump = gravity * timeToJumpPeak
signal jumped


func _physics_process(_delta):
	
	var direction = Vector3.ZERO
	direction.z = Input.get_axis("ui_up", "ui_down")
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction = direction.normalized()
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_on_floor():
		velocity.y -= gravity
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump
		
	move_and_slide()
