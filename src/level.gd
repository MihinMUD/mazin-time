extends Node3D


@onready var jumpCounter = $HUD/Jump
@onready var levelCounter = $HUD/Counter/Level/Counter/Label
@onready var timeCounter = $HUD/Timer
@onready var timer = $Timer

@export var nextScene:PackedScene;
@export var lose:PackedScene;
@export var jump = 10
@export var time = 60
@export var timerIncrement = 10

signal scored
var level = 1

func _ready():
	jumpCounter.text = str(jump)
	levelCounter.text = str(level)
	timeCounter.text = str(time)


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
		get_tree().change_scene_to_packed(lose)


func _on_gate_body_entered(_body):
	time += timerIncrement
	newLevel()


func _on_timer_timeout():
	time -= 1
	timeCounter.text = str(time)
	if time < 0:
		get_tree().change_scene_to_packed(lose)
