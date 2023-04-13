extends GridMap

# defines the board size
var level_size = Vector2(16,16)
# defines the starting position 
@onready var player = $"../player"

func _ready():
	drawMap(makeMaze(level_size))
# randomizes the board when space button is clicked
func _process(_delta):
	randomize()

func _on_player_jumped():
	emptyLevel(level_size)
	var grid = makeMaze(level_size)
	drawMap(grid)

func _on_node_3d_scored():
	emptyLevel(level_size)
	var grid = makeMaze(level_size)
	drawMap(grid)

# Generates a maze using the Sidewinder algorithm and returns a 2D array representing the maze.
# The size of the maze is specified by the `size` argument, which is a Vector2 where `x` is the width and `y` is the height of the maze.
# Each cell in the returned 2D array is represented by an integer where `0` represents a wall and `-1` represents a clear space.
func makeMaze(size: Vector2) -> Array:
	var width  = size.x
	var height = size.y
	var maze = []
	# Initialize the maze with all walls
	for x in range(width):
		var col = []
		for y in range(height):
			col.append(0)
		maze.append(col)


	# Carve passages using the Sidewinder algorithm
	for y in range(0, height, 2):
		var run_start = 1
		for x in range(0, width, 2):
			# Carve a clear space at the current position
			maze[x][y] = -1
			# If we're not on the top row and either we're on the rightmost column or randomly decide to end the current run
			if y > 1 and (x == width - 2 or randi_range(0,1) == 0):
				# Choose a random position within the current run and carve a passage north
				var run_end = x
				var carve_x = randi_range(run_start, run_end)
				maze[carve_x][y - 1] = -1
				# Start a new run
				run_start = x + 2
			# If we're not on the rightmost column, carve a passage east
			elif x < width - 2:
				maze[x + 1][y] = -1
	
	maze = cleanUpMaze(maze)
	return maze
	
# simply takes an input of an array that represents a maze and draws it on the grid map
func drawMap(vector:Array):
	for x in range(vector.size()):
		for z in range(vector[x].size()):
			var pos = Vector3i(x,0,z)
			set_cell_item(pos, vector[x][z])


func cleanUpMaze(maze: Array) -> Array:
	var width = maze.size()
	var height = maze[0].size()
	
	# clears the position near the player
	var playerX = floor(player.position.x / 4)
	var playerY = floor(player.position.z / 4)
	
	maze[playerX][playerY] = -1
	maze[playerX][playerY -1 ] = -1
	maze[playerX - 1][playerY] = -1
	
	# Set the value of every cell around the border to 0
	for x in range(width):
		maze[x][0] = 0
		maze[x][height - 1] = 0
	for y in range(height):
		maze[0][y] = 0
		maze[width - 1][y] = 0
		
	var newMaze = maze
	# Set the value of any cell with more than 3 adjacent walls to 0
	for x in range(1, width - 1):
		for y in range(1, height - 1):
			var wall_count = 0
			if maze[x - 1][y] == 0:
				wall_count += 1
			if maze[x + 1][y] == 0:
				wall_count += 1
			if maze[x][y - 1] == 0:
				wall_count += 1
			if maze[x][y + 1] == 0:
				wall_count += 1
			if wall_count > 3:
				newMaze[x][y] = 0
				
	newMaze[width-2][height-2] = -1
	
	newMaze[3][3] = -1
	newMaze[3][2] = -1
	newMaze[2][3] = -1
	newMaze[2][2] = -1
	
	
	
	return newMaze
func emptyLevel(size:Vector2):
	for x in range(size.x):
		for z in range(size.y ):
			set_cell_item(Vector3i(x,0, z), -1)


