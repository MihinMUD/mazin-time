extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("open")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
