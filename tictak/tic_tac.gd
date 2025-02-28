extends Node

var greed_data : Array
var greed_pos : Vector2i
var board_size : int
var cell_size : int

func _ready() -> void:
	board_size = $Board.texture.get_width()
	cell_size = board_size / 3 
	new_game()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x < board_size:
				greed_pos = Vector2i(event.position / cell_size)
				greed_data[greed_pos.y][greed_pos.x] = 1
				print(greed_data)

func  new_game():
	greed_data = [
		[0,0,0],
		[0,0,0],
		[0,0,0]
		]
