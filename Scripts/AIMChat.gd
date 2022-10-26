extends TextureRect


onready var text = get_parent().get_node("Dialogue").dialogue_1
onready var global = get_node("/root/global")
onready var pauseDialogue = global.pauseDialogue
var threeChoices = preload("res://UI/UI Assets/choices_base_three.png")
var twoChoices = preload("res://UI/UI Assets/choices_base_two.png")

var dialogue_index = 0
var active
var finished


var position
var expression
var choiceArray

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
					$TextBox/Tween.stop_all()
					$TextBox/RichTextLabel.percent_visible = 1
					finished = true
		
		#This is the bit that chooses the sprites showing up on screen for
		# people who aren't the MC
		if $TextBox/Label.text == "Bob":
			$Sprite.visible = true
			if position == "1":
				$Sprite.global_position = get_parent().get_node("1").position
			if position == "2":
				$Sprite.global_position = get_parent().get_node("2").position
			if position == "3":
				$Sprite.global_position = get_parent().get_node("3").position
			if position == "4":
				$Sprite.global_position = get_parent().get_node("4").position
			
			#This chooses expressions that show up on textbox
			if expression == "Happy":
				$TextBox/Speaking.texture = global.happy_expression
		
		
		#This is the code that determines what choices show up
		if $"Choices/Choice 1".text == "":
			$"Choices/Choice 1".visible = false
			$Choices.visible = false
			pauseDialogue = false #This is to make sure that the dialogue doesn't pause when there are no choices
		elif $"Choices/Choice 1".text != "" && pauseDialogue == false:
			$"Choices/Choice 1".visible = true
			$Choices.visible = true
			pauseDialogue = true #This is to make sure that the dialogue pauses when there are choices
		else:
			$"Choices/Choice 1".visible = true
			$Choices.visible = true
		
		if $"Choices/Choice 2".text == "":
			$"Choices/Choice 2".visible = false
		else:
			$"Choices/Choice 2".visible = true
		
		if $"Choices/Choice 3".text == "":
			$"Choices/Choice 3".visible = false
			$Choices.texture = twoChoices #This is to make sure that the texture displays the right amount of slots for the given choices
		else:
			$"Choices/Choice 3".visible = true
			$Choices.texture = threeChoices #This is to make sure that the texture displays the right amount of slots for the given choices

func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
		
		#This is the code that determines the content of each option box
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text = text[dialogue_index]["Text"]
		$TextBox/Label.text = text[dialogue_index]["Name"]
		$"Choices/Choice 1".bbcode_text = "[center]" + text[dialogue_index]["Choices"][0] + "[/center]"
		$"Choices/Choice 2".bbcode_text = "[center]" + text[dialogue_index]["Choices"][1] + "[/center]"
		$"Choices/Choice 3".bbcode_text = "[center]" + text[dialogue_index]["Choices"][2] + "[/center]"
		
		position = text[dialogue_index]["Position"] #This is to make sure that the code knows where to place the sprite based on the contents of the dialogue node
		expression = text[dialogue_index]["Expression"] #This is to make sure that the code knows what expression to display based on the contents of the dialogue node
		choiceArray = text[dialogue_index]["Choices"] #This is to make sure that the code knows what choices to display based on the contents of the dialogue node
		
		#This is the code that controls the transition between dialogue box contents
		$TextBox/RichTextLabel.percent_visible = 0
		$TextBox/Tween.interpolate_property(
			$TextBox/RichTextLabel, "percent_visible", 0, 1, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		
		$TextBox/Tween.start()
	else:
		$TextBox.visible = false
		finished = true
		active = false
	dialogue_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true

func _on_Exit_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")
	pass # Replace with function body.
