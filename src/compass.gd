extends TextureRect
@export var start:Node
@export var end:Node
func _process(delta):
	var axis = rad_to_deg(start.position.angle_to(end.position))
	rotation = axis
