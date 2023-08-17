extends GridMap

# defines the board size
var level_size = Vector2(17,17)
# defines the starting position 
@onready var player = $"../player"
const FLOOR = 0
const WALL = 1
const SPACE = -1

func _ready():
	drawMap(makeMaze(level_size))

func _on_player_jumped():
	drawMap(makeMaze(level_size))

func _on_node_3d_scored():
	drawMap(makeMaze(level_size))

# Generates a maze using the Sidewinder algorithm and returns a 2D array representing the maze.
# The size of the maze is specified by the `size` argument, which is a Vector2 where `x` is the width and `y` is the height of the maze.
# Each cell in the returned 2D array is represented by an integer where `0` represents a wall and `-1` represents a clear space.

func makeMaze(size: Vector2):
	randomize()
	var width  = size.x
	var height = size.y
	var maze = []
	# Initialize the maze with all walls
	for x in range(width):
		var col = []
		for y in range(height):
			col.append(WALL)
		maze.append(col)
	
	
	# makes a dot pattern
	for x in range(1, width, 2):
		for y in range(1, height, 2):
			maze[x][y] = SPACE
	
	for x in range(1, width, 2):
		for y in range(1, height , 2):

			var directions = ["down", "right"]
			var randomDirection = directions[randi_range(0,1)]

			if randomDirection == "right":
				maze[x+1][y] = SPACE

			if randomDirection == "down":
				maze[x][y + 1] = SPACE
				if maze[x - 1][y] == WALL and maze[x][y - 1] == WALL:
					maze[x - 1][y] = SPACE
					maze[x + 1][y] = SPACE
					
	# clear up player and gate blocks
	var playerX = floor(player.position.x / 4)
	var playerY = floor(player.position.z / 4)

	maze[playerX][playerY] = SPACE
	maze[playerX][playerY -1 ] = SPACE
	maze[playerX - 1][playerY] = SPACE

	maze[3][3] = SPACE
	maze[3][2] = SPACE
	maze[2][3] = SPACE
	maze[2][2] = SPACE
	# Loop through the first and last rows
	for x in range(width):
		maze[x][0] = WALL
		maze[x][height - 1] = WALL
	for y in range(height):
		maze[0][y] = WALL
		maze[width - 1][y] = WALL
		
		
	
	# returns a map array with 2 properties maze array and the size
	return [maze, Vector2(width, height)]
	
# simply takes an input of an array that represents a maze and draws it on the grid map
func drawMap(map:Array):
	var vector = map[0]
	var size = map[1]
	#adds the floor 
	for x in range(size.x):
		for z in range(size.y):
			set_cell_item(Vector3i(x,-1, z), FLOOR)
	
	# adds the maze
	for x in range(vector.size()):
		for z in range(vector[x].size()):
			var pos = Vector3i(x,0,z)
			set_cell_item(pos, vector[x][z])
