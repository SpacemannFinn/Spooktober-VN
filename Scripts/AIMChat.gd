extends TextureRect

onready var global = get_node("/root/global")
onready var pauseDialogue = global.pauseDialogue
onready var dict = global.readJSON("res://Dialog/main.json")

export(String) var start_id

var previous
var current
var active
var finished
var audioplayed = false

onready var choices = $"Choice Box/AIMChoices"
onready var chat = $Chat/VBoxContainer


var ping = preload("res://Music + SFX/Spooktober 2022 SFX/IM_message.mp3")
var login = preload("res://Music + SFX/Spooktober 2022 SFX/IM_log_in.mp3")
var logout = preload("res://Music + SFX/Spooktober 2022 SFX/IM_log_out.mp3")
var newNPCLabel
var nameColor

var count = 0



func _ready():
	login.loop = false
	$AudioStreamPlayer.stream = login
	$AudioStreamPlayer. play()
	start(start_id)

func _physics_process(delta):
	if active:
		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				if pauseDialogue == false:
					current = dict[current]['options']['0']['link']
					load_dialogue(current)
					if !current == 'END':
						for num in dict[current]['options']:
							count+=1
			else:
				newNPCLabel.get_child(1).stop_all()
				newNPCLabel.percent_visible = 1
				finished = true
		
		#This is the code that determines what choices show up
		if count <= 1:
			pauseDialogue = false
		elif count <= 2:
			pauseDialogue = true
			choices.show()
			choices.get_child(2).hide()
		elif count == 3:
			pauseDialogue = true
			choices.show()
			choices.get_child(2).show()
		
		
		# if single empty option
		if !current == 'END':
			if len(dict[current]['options']) == 1:
				choices.hide()

func load_dialogue(idx):
	if idx == "END":
		stop()
		return
	
	active = true
	finished = false
	
	var type = idx.split('_')[0]
	
	match(type):
		'0':
			#starting node
			current = dict[idx]['link']
			load_dialogue(current)
		'1':
			#dialogue
			
			var speaker = dict[idx]["speaker"]
			newNPCLabel = newNPCChatBox()
			chat.add_child(newNPCLabel)
			newNPCLabel.get_child(1).connect('tween_completed', self, '_on_Tween_tween_completed')
			
			match(speaker):
				'Bestie':
					nameColor = "252FAA"
				'Player':
					nameColor = "B21E55"
			
			var dia = dict[idx]['dialogue']
			if !dia == '' || !dia == ' ': 
				newNPCLabel.bbcode_text = "[color=#" + nameColor + "]" + speaker + ":[/color] " + "[color=#0a0404]" + dia + "[/color]"
			else:
				newNPCLabel.bbcode_text = ' '
			
			for num in dict[idx]['options']:
				var choice = choices.get_child(int(num))
				var text = dict[idx]['options'][num]['text']
				if !text == '' || !text == ' ':
					choice.bbcode_text = '[center]' + text + '[/center]'
				else:
					choice.bbcode_text = ''
			
			#Writes current dialogue to History
			var historydia = str(speaker) + ": " + str(dia)
			global.writeHistory(str(historydia))
			
			
			count = 0
		'3':
			# signal
			emit_signal('dialogue_signal', dict[idx]['signalValue'])
			current = dict[idx]['link']
			load_dialogue(current)
			
		
		#This is the code that controls the transition between dialogue box contents
	newNPCLabel.percent_visible = 1
	newNPCLabel.get_child(1).interpolate_property(
		newNPCLabel, "percent_visible", 0, 1, 5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
		
	newNPCLabel.get_child(1).start()


func _on_Tween_tween_completed(object, key):
	finished = true

func _on_Exit_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")
	pass # Replace with function body.

func newNPCChatBox():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Font/Ubuntu-Regular.ttf")
	dynamic_font.size = 34
	dynamic_font.outline_size = 0
	
	var IMsfx = AudioStreamPlayer.new()
	ping.loop = false
	IMsfx.stream = ping
	IMsfx.bus = 'SFX'
	IMsfx.play()
	
	var tween = Tween.new()
	tween.emit_signal("tween_completed")
	
	var newChatBox = RichTextLabel.new()
	newChatBox.bbcode_text = ""
	newChatBox.bbcode_enabled = true
	newChatBox.fit_content_height = true
	newChatBox.rect_min_size = Vector2(984, 40)
	newChatBox.rect_scale = Vector2(1, 1)
	newChatBox.rect_clip_content = true
	newChatBox.add_font_override("normal_font", dynamic_font)
	newChatBox.add_child(tween)
	newChatBox.add_child(IMsfx)
	
	return newChatBox

func start(id):
	if !dict:
		printerr("No dialogue data!")
		return
	elif !dict['start'][id]:
		printerr('Start ID not present')
		return
	current = dict['start'][id]
	load_dialogue(current)

func stop():
	choices.hide()
	finished = true
	active = false

func _pressed(arg):
	current = dict[current]['options'][arg]['link']
	load_dialogue(current)
	pass


func saveData():
	var saveDict = {
		"saveImage": "",
		"startid": start_id,
		"currentDia": current,
		"scene": get_tree().current_scene.filename,
		"date": "",
		"time": ""
	}
	return saveDict
