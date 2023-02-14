extends Control
onready var global = get_node("/root/global")
onready var dict = global.readJSON("res://SavedData/history.json")
onready var histList = get_node("History/AllInfo")
var count = 0


func _process(delta):
	if dict == null:
		return
	if(count >= len(dict)):
		return
	loadHistory()

func loadHistory():
	count = 0
	for hist in dict:
		var text = historyText()
		histList.add_child(text)
		var hists = histList.get_child(count)
		hists.bbcode_text = hist
		count+=1


func historyText():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Font/Ubuntu-Regular.ttf")
	dynamic_font.size = 34
	dynamic_font.outline_size = 0
	
	var newChatBox = RichTextLabel.new()
	newChatBox.bbcode_text = ""
	newChatBox.bbcode_enabled = true
	newChatBox.fit_content_height = true
	newChatBox.rect_min_size = Vector2(984, 40)
	newChatBox.rect_scale = Vector2(1, 1)
	newChatBox.rect_clip_content = true
	newChatBox.add_font_override("normal_font", dynamic_font)
	
	return newChatBox
