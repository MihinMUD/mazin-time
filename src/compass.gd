extends TextureRect

@onready var player = $"../player"

func _physics_process(_delta):
	var playerPos = Vector2(player.position.x , player.position.z)
	$player.position = playerPos * 2
