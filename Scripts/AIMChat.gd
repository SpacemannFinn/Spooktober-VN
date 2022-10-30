extends TextureRect


onready var text = get_node("Dialogue").dialogue_1
onready var global = get_node("/root/global")
onready var pauseDialogue = global.pauseDialogue

var dialogue_index = 0
var active
var finished
var count = 0
var choiceArray
var newNPCLabel
var nameColor

func _ready():
	load_dialogue()

func _physics_process(delta):
	if active:
		# If the player presses the spacebar, the dialogue will continue
		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				if pauseDialogue == false:
					load_dialogue()
			else:
				if pauseDialogue == false: # If the dialogue is not paused, the dialogue will continue
					#$TextBox/Tween.stop_all()
					#$TextBox/RichTextLabel.percent_visible = 1
					finished = true
		
		#This is the code that determines what choices show up
		if $"Choice Box/AIMChoices/Choice 1".text == "":
			$"Choice Box/AIMChoices/Choice 1".visible = false
			pauseDialogue = false #This is to make sure that the dialogue doesn't pause when there are no choices
		elif $"Choice Box/AIMChoices/Choice 1".text != "" && pauseDialogue == false:
			$"Choice Box/AIMChoices/Choice 1".visible = true
			pauseDialogue = true #This is to make sure that the dialogue pauses when there are choices
		else:
			$"Choice Box/AIMChoices/Choice 1".visible = true
		
		if $"Choice Box/AIMChoices/Choice 2".text == "":
			$"Choice Box/AIMChoices/Choice 2".visible = false
		else:
			$"Choice Box/AIMChoices/Choice 2".visible = true
		
		if $"Choice Box/AIMChoices/Choice 3".text == "":
			$"Choice Box/AIMChoices/Choice 3".visible = false
		else:
			$"Choice Box/AIMChoices/Choice 3".visible = true

func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
		
		#This is the code that determines the content of each option box
		newNPCLabel = newNPCChatBox()
		$Chat/VBoxContainer.add_child(newNPCLabel)
		if(text[dialogue_index]["Name"] == "Bob"):
			nameColor = "252FAA"
		elif(text[dialogue_index]["Name"] == "Alice"):
			nameColor = "B21E55"

		newNPCLabel.bbcode_text = "[color=#" + nameColor + "]" + text[dialogue_index]["Name"] + ":[/color] " + "[color=#0a0404]" + text[dialogue_index]["Text"] + "[/color]"
		$"Choice Box/AIMChoices/Choice 1".bbcode_text = "[center]" + text[dialogue_index]["Choices"][0] + "[/center]"
		$"Choice Box/AIMChoices/Choice 2".bbcode_text = "[center]" + text[dialogue_index]["Choices"][1] + "[/center]"
		$"Choice Box/AIMChoices/Choice 3".bbcode_text = "[center]" + text[dialogue_index]["Choices"][2] + "[/center]"
		
		choiceArray = text[dialogue_index]["Choices"] #This is to make sure that the code knows what choices to display based on the contents of the dialogue node
		
		#This is the code that controls the transition between dialogue box contents
		newNPCChatBox().percent_visible = 0
		$Chat/Tween.interpolate_property(
		newNPCChatBox(), "percent_visible", 0, 1, 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		
		$Chat/Tween.start()
	else:
		#$TextBox.visible = false
		finished = true
		active = false
	dialogue_index += 1


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

	var newChatBox = RichTextLabel.new()
	newChatBox.bbcode_text = ""
	newChatBox.bbcode_enabled = true
	newChatBox.fit_content_height = true
	newChatBox.rect_min_size = Vector2(984, 40)
	newChatBox.rect_scale = Vector2(1, 1)
	newChatBox.rect_clip_content = true
	newChatBox.add_font_override("normal_font", dynamic_font)
	return newChatBox
