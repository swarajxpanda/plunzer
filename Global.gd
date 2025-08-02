extends Node

var node_creation_parent = null
var player = null

var points = 0
var highscore = 0

var camera = null

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func save():
	var save_dict = {
		"highscore": highscore
	}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://SavedGame.save", File.WRITE, "enc")
	save_game.store_line(to_json(save()))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://SavedGame.save"):
		return
	save_game.open_encrypted_with_pass("user://SavedGame.save", File.READ, "enc")
	
	var json_text = save_game.get_line()
	var current_line = parse_json(json_text)

	if typeof(current_line) == TYPE_DICTIONARY:
		highscore = current_line["highscore"]
	else:
		print("Failed to parse save file or empty data: ", json_text)
	save_game.close()
