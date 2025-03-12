extends Node

@export var circle_scene : PackedScene
@export var cross_scene : PackedScene


var greed_data : Array
var greed_pos : Vector2i
var board_size : int
var cell_size : int
var player : int
var winner : int
var moves : int 
var row_sum : int
var column_sum : int
var diagonal_sum : int
var diagonal2_sum : int 

func _ready() -> void:
	board_size = $Board.texture.get_width()
	cell_size = board_size / 3
	$Panel/cross.visible = true
	new_game()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x < board_size:
				greed_pos = Vector2i(event.position / cell_size)
				if greed_data[greed_pos.y][greed_pos.x] == 0:
					moves += 1
					greed_data[greed_pos.y][greed_pos.x] = player 
					create_marker(player, greed_pos * cell_size + Vector2i(cell_size/2, cell_size/2))
					if check_win() != 0:
						get_tree().paused = true
						$GameOverMenu.visible = true
						#$GameOverMenu.show()
						$GameOverMenu.get_node("ResultLabel").text = "Player %s Wins!!" %winner
					elif moves == 9:
						get_tree().paused = true
						$GameOverMenu.visible = true
						$GameOverMenu.get_node("ResultLabel").text = "It's a Tie"
					player *= -1
					circle_visible(player)
					print(greed_data)

func new_game():
	$GameOverMenu.visible = false
	#$GameOverMenu.hide()
	get_tree().paused = false
	player = 1
	moves = 0 
	winner = 0
	greed_data = [
		[0,0,0],
		[0,0,0],
		[0,0,0]
		]

func create_marker(player,position):
	if player == -1:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
		#$Panel/circle.visible = false
		#$Panel/cross.visible = true
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)
		#$Panel/cross.visible = false
		#$Panel/circle.visible = true

func circle_visible(player):
	$Panel/cross.visible = false
	$Panel/circle.visible = false
	if player == 1:
		$Panel/cross.visible = true
	else :
		$Panel/circle.visible = true
	
func check_win():
	for i in len(greed_data):
		row_sum = greed_data[i][0] + greed_data[i][1] + greed_data[i][2]
		column_sum = greed_data[0][i] + greed_data[1][i] + greed_data[2][i]
		diagonal_sum = greed_data[0][0] + greed_data[1][1] + greed_data[2][2]
		diagonal2_sum = greed_data[0][2] + greed_data[1][1] + greed_data[2][0]
		if row_sum == 3 or column_sum == 3 or diagonal_sum == 3 or diagonal2_sum == 3:
			winner = 1 
		elif row_sum == -3 or column_sum == -3 or diagonal_sum == -3 or diagonal2_sum == -3:
			winner = -1
	return winner 

#func _on_game_over_menu_restart() -> void:
	#get_tree().reload_current_scene()
