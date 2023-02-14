extends Node

var textSpeed = 0
var pauseDialogue
var dict = []
var happy_expression = "res://Art/Sprites/expression_bestie_nervous.png"

var has_signaled = false
var _config_file = ConfigFile.new()
var _settings = {
	"settings": {
		"MusicVolume": 0,
		"SFXVolume": 0,
		"TextSpeed": 0
	}
}

var image

const SAVEPATH = "res://SavedData/save.dat"
var _saveInfo
var _loadInfo

var _saves = {
	"saves": {
		"1": {},
		"2": {},
		"3": {},
		"4": {}
	}
}

var newCurrent

func readJSON(var filename: String):
	var file = File.new()
	
	if file.file_exists(filename) == false:
		writeJSON("", filename)
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

func writeJSON(var info: String, var path: String = "res://SavedData/dump.txt"):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(to_json(info))
	file.close()


func saveSettings(PATH):
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(PATH)


func loadSettings(PATH):
	var err = _config_file.load(PATH)
	if err != OK:
		print("Error loading settings. Error Code %s" % err)
		return null
	
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)



func saveGame(slot):
	var save_file = File.new()
	
	#If file doesn't exist, initialise it
	if !save_file.file_exists(SAVEPATH):
		save_file.open(SAVEPATH, File.WRITE)
		save_file.store_line(to_json(_saves))
	
	save_file.open(SAVEPATH, File.READ)
	_saves = parse_json(save_file.get_as_text())
	
	#Takes Screenshot
	#get_node("/root/BaseTexture/SaveMenu").hide()
	image.resize(538, 300,Image.INTERPOLATE_NEAREST)
	image.save_png("res://SavedData/00" + slot + ".png")
	#get_node("/root/BaseTexture/SaveMenu").show()
	
	#Adds Image Reference, Date and Time to the Save Information before it is added to the save file
	var time = OS.get_datetime()
	print(_saveInfo)
	_saveInfo["saveImage"] = "00" + slot
	_saveInfo["date"] = str(time["day"]).pad_zeros(2)+ "." + str(time["month"]).pad_zeros(2) + "." + str(time["year"])
	_saveInfo["time"] = str(time["hour"]).pad_zeros(2) + ":" + str(time["minute"]).pad_zeros(2) + ":" + str(time["second"]).pad_zeros(2)
	
	print("this is the save information ", _saveInfo)
	
	#Adds info to the relevant slot in the save file and writes the save
	_saves["saves"][slot] = _saveInfo
	
	save_file.open(SAVEPATH, File.WRITE)
	save_file.store_line(to_json(_saves))
	save_file.close()


func loadGame(slot = "1"):
	var save_file = File.new()
	var tempLoad = {}
	#If file doesn't exist, don't try to load the file
	if !save_file.file_exists(SAVEPATH):
		save_file.open(SAVEPATH, File.WRITE)
		save_file.store_line(to_json(_saves))
	
	#Parse the file data
	save_file.open(SAVEPATH, File.READ)
	tempLoad = parse_json(save_file.get_as_text())
	
	print(tempLoad["saves"]["1"])
	#Info for a specific slot is loaded into the variable
	_loadInfo = tempLoad["saves"][slot]
	
	return tempLoad
