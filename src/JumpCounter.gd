extends Panel

@onready var label = $Label
@export var lose:PackedScene;
var score = 100
var labelText = "Score: "


func _ready():
	label.text = labelText + str(score)

func _on_grid_jumped():
	score -= 10
	label.text = labelText + str(score)
	if score < 0:
		print("smaller")
		get_tree().change_scene_to_packed(lose)
