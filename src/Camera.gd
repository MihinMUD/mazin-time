extends Camera3D

@onready var hiddenMouse = true
const ROTATE_SPEED = 0.005
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	rotation.x = clamp(rotation.x, -1, 1)
	rotation.z = 0
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED if hiddenMouse else Input.MOUSE_MODE_CAPTURED)
		hiddenMouse = !hiddenMouse

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseMotion and hiddenMouse:
		rotate(Vector3.UP, -event.relative.x * ROTATE_SPEED)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * ROTATE_SPEED)
