extends Node

@onready var player = $"../../player"

func _physics_process(_delta):
	var playerPos = Vector2(player.position.x , player.position.z)
	$Control/player.position = playerPos
