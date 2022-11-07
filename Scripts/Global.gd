extends Node

var pauseDialogue
var dict = []
var happy_expression = preload("res://Art/Sprites/expression_bestie_nervous.png")

var has_signaled = false

func readJSON(filename):  
	var file = File.new()  
	file.open(filename, File.READ)  
	var data=  parse_json(file.get_as_text())
	file.close()  
	return data   

func writeJSON(var info: String):
	dict.append(info)
	print(dict)
	var path = "res://SavedData/history.txt"
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(str(dict))
	file.close()
	pass
