extends Control

onready var text = get_parent().get_node("Dialogue").dialogue_1
onready var global = get_node("/root/global")

var threeChoices = preload("res://UI/UI Assets/choices_base_three.png")
var twoChoices = preload("res://UI/UI Assets/choices_base_two.png")

var dialogue_index = 0
var active
var finished
var pauseDialogue

var position
var expression
var choiceArray

func _ready():
	load_dialogue()

func _physics_process(delta):
	if active:
		
		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				if pauseDialogue == false:
					load_dialogue()
			else:
				if pauseDialogue == false:
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
		
		
		
		if $"Choices/Choice 1".text == "":
			$"Choices/Choice 1".visible = false
			$Choices.visible = false
			pauseDialogue = false
		else:
			$"Choices/Choice 1".visible = true
			$Choices.visible = true
			pauseDialogue = true
		
		if $"Choices/Choice 2".text == "":
			$"Choices/Choice 2".visible = false
		else:
			$"Choices/Choice 2".visible = true
		
		if $"Choices/Choice 3".text == "":
			$"Choices/Choice 3".visible = false
			$Choices.texture = twoChoices
		else:
			$"Choices/Choice 3".visible = true
			$Choices.texture = threeChoices

func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
		
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text = text[dialogue_index]["Text"]
		$TextBox/Label.text = text[dialogue_index]["Name"]
		$"Choices/Choice 1".bbcode_text = "[center]" + text[dialogue_index]["Choices"][0] + "[/center]"
		$"Choices/Choice 2".bbcode_text = "[center]" + text[dialogue_index]["Choices"][1] + "[/center]"
		$"Choices/Choice 3".bbcode_text = "[center]" + text[dialogue_index]["Choices"][2] + "[/center]"
		
		position = text[dialogue_index]["Position"]
		expression = text[dialogue_index]["Expression"]
		choiceArray = text[dialogue_index]["Choices"]
		
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
