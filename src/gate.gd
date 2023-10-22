extends Node3D

@export var disabled = false
signal on_entered(body)

func _ready():
	if not disabled:
		$Wall.set_collision_layer_value(1, false)
func _on_enter_detect_body_entered(body):
	if not disabled:
		emit_signal("on_entered", body)


func _on_gate_open_detect_body_entered(_body):
	if not disabled:
		$gate/AnimationPlayer.play("open")


func _on_gate_open_detect_body_exited(_body):
	if not disabled:
		$gate/AnimationPlayer.play_backwards("open")
