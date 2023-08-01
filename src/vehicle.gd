extends CharacterBody3D

@onready var camera = $Camera

var jumpHeight = 20
var timeToJumpPeak = 20
var speed = 5
@warning_ignore("integer_division")
var gravity = int(2 * jumpHeight / (timeToJumpPeak ^ 2))
var jump = gravity * timeToJumpPeak
signal jumped


func _physics_process(_delta):
	
	var direction = Vector3.ZERO
	direction.z = Input.get_axis("up", "down")
	direction.x = Input.get_axis("left", "right")
	direction += direction.normalized()
	direction = direction.rotated(Vector3.UP, camera.rotation.y)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_on_floor():
		velocity.y -= gravity
	elif Input.is_action_just_pressed("ui_accept"):
		emit_signal("jumped")
		velocity.y = jump
		
	move_and_slide()
