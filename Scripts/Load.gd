extends Control
onready var global = get_node("/root/global")
onready var allinfo = $Savables/MarginContainer/AllInfo
var temp

func _ready():
	_createSlots()
	

func _createSlots():
	var pos = 0
	temp = global.loadGame()
	for saves in temp.keys():
		for saveSlot in temp[saves]:
			
			if temp[saves][saveSlot].empty():
				continue
			
			
			var dict = temp[saves].keys()
			var path = "res://SavedData/00"+str(saveSlot) + ".png"
			var date = temp[saves][saveSlot]["date"]
			var time = temp[saves][saveSlot]["time"]
			
			
			var saveElement = newSaveElement(path, dict[pos], date, time)
			allinfo.add_child(saveElement)
			
			pos += 1
			print(pos)

func _hydrateSlots(slot):
	temp = global.loadGame()
	var loaded = temp["saves"][slot]
	global.loadStart = loaded["startid"]
	global.loadCurrent =  loaded["currentDia"]
	get_tree().change_scene(loaded["scene"])
	print(loaded)
	

func newSaveElement(path, slot, dateFromSave, timeFromSave):
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Font/Ubuntu-Regular.ttf")
	dynamic_font.size = 60
	dynamic_font.outline_size = 0
	
	var dynamic_font2 = DynamicFont.new()
	dynamic_font2.font_data = load("res://Font/Ubuntu-Regular.ttf")
	dynamic_font2.size = 50
	dynamic_font2.outline_size = 0
	
	var save_photo = TextureRect.new()
	save_photo.texture = load(path)
	
	var save_frame = TextureRect.new()
	save_frame.texture = load("res://UI/UI Assets/files_screenshot_frame.png")
	
	var save_hover = TextureButton.new()
	save_hover.texture_hover = load("res://UI/UI Assets/files_screenshot_frame_hover.png")
	save_hover.texture_pressed = load("res://UI/UI Assets/files_screenshot_frame_hover.png")
	save_hover.connect("pressed", self, "_hydrateSlots", [slot])
	
	var info = Control.new()
	info.rect_position = Vector2(0, -20)
	
	var save_info = TextureRect.new()
	save_info.texture = load("res://UI/UI Assets/files_infobox_base.png")
	save_info.rect_position = Vector2(22.5, 330)
	
	var save_slot = Label.new()
	save_slot.rect_size = Vector2(34, 68)
	save_slot.rect_position = Vector2(57.65, 346)
	save_slot.text = slot
	save_slot.align = Label.ALIGN_CENTER
	save_slot.valign = Label.VALIGN_CENTER
	save_slot.add_font_override("font", dynamic_font)
	
	var delete = Label.new()
	delete.rect_size = Vector2(26, 57)
	delete.rect_position = Vector2(61.65, 449)
	delete.text = "x"
	delete.align = Label.ALIGN_CENTER
	delete.valign = Label.VALIGN_CENTER
	delete.add_font_override("font", dynamic_font2)
	
	var date = RichTextLabel.new()
	date.rect_position = Vector2(168, 353)
	date.rect_size = Vector2(322, 77)
	date.bbcode_enabled = true
	date.bbcode_text = "[center]" + dateFromSave + "[/center]"
	date.add_font_override("normal_font", dynamic_font)
	
	var time = RichTextLabel.new()
	time.rect_position = Vector2(161.834, 434)
	time.rect_size = Vector2(328, 76.5)
	time.bbcode_enabled = true
	time.bbcode_text = "[center]" + timeFromSave + "[/center]"
	time.add_font_override("normal_font", dynamic_font)
	
	info.add_child(save_info)
	info.add_child(save_slot)
	info.add_child(delete)
	info.add_child(date)
	info.add_child(time)
	
	var newSaveSlot = TextureRect.new()
	newSaveSlot.texture = load("res://UI/UI Assets/files_screenshot_base.png")
	newSaveSlot.rect_size = Vector2(541, 540)
	newSaveSlot.add_child(save_photo)
	newSaveSlot.add_child(save_frame)
	newSaveSlot.add_child(save_hover)
	newSaveSlot.add_child(info)
	
	
	return newSaveSlot
