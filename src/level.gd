extends Node3D


@onready var jumpCounter = $HUD/Jump/Counter/Label
@onready var levelCounter = $HUD/Level/Counter/Label

@export var nextScene:PackedScene;
@export var lose:PackedScene;
signal scored
var jump = 10
var level = 1

func _ready():
	jumpCounter.text = str(jump)
	levelCounter.text = str(level)

func newLevel():
	$AnimationPlayer.play("new")
	level += 1
	levelCounter.text = str(level)
	$player.position = Vector3(58,2,58)
	emit_signal("scored")
	
	
func _on_player_jumped():
	jump -= 1
	jumpCounter.text = str(jump)
	if jump < 0:
		print("smaller")
		get_tree().change_scene_to_packed(lose)


func _on_gate_body_entered(_body):
	newLevel()
