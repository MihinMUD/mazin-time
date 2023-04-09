extends Camera3D
@export var x_change = 0
@export var z_change = 12
@export var y_change = 8
@export var angle = -30
@export var player_path:NodePath

@onready var player = get_node(player_path)

func _ready():
	rotation_degrees.x = angle
	position.y = y_change


func _process(_delta):
	position.x = player.position.x + x_change
	position.z = player.position.z + z_change
