extends Node

var pauseDialogue
var dict = []
var happy_expression = preload("res://Art/Sprites/expression_bestie_nervous.png")

var has_signaled = false

func readJSON(var filename: String):
	var file = File.new()
	
	if file.file_exists(filename) == false:
		writeJSON("")
		return
	
	file.open(filename, File.READ)
	var data=  parse_json(file.get_as_text())
	file.close()
	return data

func writeJSON(var info: String):
	var path = "res://SavedData/history.json"
	var file = File.new()
	file.open(path, File.READ_WRITE)
	file.seek_end()
	file.store_line(to_json(info))
	file.close()

