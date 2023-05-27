extends CharacterBody3D

var jumpHeight = 20
var timeToJumpPeak = 20
var speed = 5
@warning_ignore("integer_division")
var gravity = int(2 * jumpHeight / (timeToJumpPeak ^ 2))
var jump = gravity * timeToJumpPeak
@onready var camera = $Camera
signal jumped


func _physics_process(_delta):
	
	var direction = Vector3.ZERO
	direction.z = Input.get_axis("up", "down")
	direction.x = Input.get_axis("left", "right")
	direction += direction.normalized()
	direction = direction.rotated(Vector3.UP, rotation.y)

	var rotateDirection = Input.get_axis("ui_right", "ui_left")
	rotation.y += deg_to_rad(rotateDirection) * 1.4
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_on_floor():
		velocity.y -= gravity
	elif Input.is_action_just_pressed("ui_accept"):
		emit_signal("jumped")
		velocity.y = jump
		
	move_and_slide()
