extends Control
onready var global = get_node("/root/global")
var temp

func _ready():
	refresh()

func refresh():
	temp = global.loadGame()
	for saves in temp.keys():
		for saveSlot in temp[saves]:
			
			if temp[saves][saveSlot].empty():
				continue
			
			#Create Save Slot Image
			var img = Image.new()
			var err = img.load("res://SavedData/00"+str(saveSlot) + ".png")
			if(err!=0):
				print("Error loading the Save Image " + saveSlot)
				return null
			
			var img_tex = ImageTexture.new()
			img_tex.create_from_image(img)
			get_node("Savables/MarginContainer/AllInfo/Save " + str(saveSlot) + "/SavePhoto").texture = img_tex
			
			#Add Date
			get_node("Savables/MarginContainer/AllInfo/Save " + str(saveSlot) + "/Info/Date").bbcode_text = "[center]" + temp[saves][saveSlot]["date"] + "[/center]"
			
			#Add Time
			get_node("Savables/MarginContainer/AllInfo/Save " + str(saveSlot) + "/Info/Time").bbcode_text = "[center]" + temp[saves][saveSlot]["time"] + "[/center]"
	


func createSave(slot):
	global.saveGame(slot)
	refresh()
	
