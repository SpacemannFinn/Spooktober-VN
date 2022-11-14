extends Node

var pauseDialogue
var dict = []
var happy_expression = "res://Art/Sprites/expression_bestie_nervous.png"

var has_signaled = false

func readJSON(var filename: String):
	var file = File.new()
	
	if file.file_exists(filename) == false:
		writeJSON("")
		return
	
	file.open(filename, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	return data

func writeHistory(var info: String):
	var path = "res://SavedData/history.json"
	var file = File.new()
	if !file.file_exists(path):
		file.open(path, File.WRITE)
		file.store_string(to_json([info]))
	else:
		file.open(path, File.READ_WRITE)
		file.seek_end(-1)
		file.store_string(",")
		file.store_line(to_json(info))
		file.store_string("]")
	file.close()

func writeJSON(var info: String, var path: String = "res//SavedData/dump.txt"):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(to_json(info))
	file.close()
