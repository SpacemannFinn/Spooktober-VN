extends Control

onready var global = get_node("/root/global")
onready var pauseDialogue = global.pauseDialogue
onready var dict = global.readJSON("res://Dialog/main.json")
var threeChoices = preload("res://UI/UI Assets/choices_base_three.png")
var twoChoices = preload("res://UI/UI Assets/choices_base_two.png")

export(String) var start_id

var previous
var current
var active
var finished

var mouse_over = false
onready var choices = $Choices

var position
var expression
var choiceArray
var speaker
var count = 0


func _ready():
	start(start_id)

func _input(event):
	if active:
		if Input.is_action_just_pressed("ui_accept") && mouse_over == true:
			if finished == true:
				if pauseDialogue == false:
					current = dict[current]['options']['0']['link']
					load_dialogue(current)
					placePosition(position, speaker)
					if !current == 'END':
						for num in dict[current]['options']:
							count+=1
					
			else:	
				$TextBox/Tween.stop_all()
				$TextBox/Dialogue.percent_visible = 1
				finished = true
	
		
		
		if count <= 1:
			pauseDialogue = false
		elif count <= 2:
			pauseDialogue = true
			choices.show()
			choices.get_child(2).hide()
			choices.texture = twoChoices
		elif count == 3:
			pauseDialogue = true
			choices.show()
			choices.get_child(2).show()
			choices.texture = threeChoices
		
		
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
			
			position = dict[idx]["position"] #Position of the Bestie Sprite
			expression = dict[idx]["expression"] #Faces of Bestie & Player
			choiceArray = dict[idx]["options"] #Array of choices
			speaker = dict[idx]["speaker"] #Speaker names
			
			$TextBox.visible = true
			
			var dia = dict[idx]['dialogue']
			if !dia == '' || !dia == ' ': 
				$TextBox/Dialogue.bbcode_text = dia
			else:
				$TextBox/Dialogue.bbcode_text = ' '
			
			#Writes current dialogue to History
			var historydia = str(speaker) + ": " + str(dia)
			global.writeHistory(str(historydia))
			
			
			placePosition(position, speaker)
			
			for num in choiceArray:
				var choice = choices.get_child(int(num))
				var text = dict[idx]['options'][num]['text']
				if !text == '' || !text == ' ':
					choice.bbcode_text = '[center]' + text + '[/center]'
				else:
					choice.bbcode_text = ''
			
			count = 0
		'3':
			# signal
			emit_signal('dialogue_signal', dict[idx]['signalValue'])
			current = dict[idx]['link']
			load_dialogue(current)
	
	
	
	
	#This is the code that controls the transition between dialogue box contents
	$TextBox/Dialogue.percent_visible = 0
	$TextBox/Tween.interpolate_property(
		$TextBox/Dialogue, "percent_visible", 0, 1, 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	
	$TextBox/Tween.start()
	



func _on_Tween_tween_completed(object, key):
	finished = true

func _on_Exit_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")
	pass # Replace with function body.

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
	$TextBox.visible = false
	finished = true
	active = false

func expressionista(speaker, expression):
	match(speaker):
		'Bestie':
			match(expression):
				'empty':
					pass
			pass
		'Player':
			match(expression):
				'empty':
					pass
			pass
	pass


func placePosition(pos, speaker):

	match(speaker):
		'Bestie':
			match(pos):
				'1':
					$Sprite.global_position = $'Position/1'.position
				'2':
					$Sprite.global_position = $'Position/2'.position
				'3':
					$Sprite.global_position = $'Position/3'.position
				'4':
					$Sprite.global_position = $'Position/4'.position
		'Player':
			pass
	


func _on_TextBox_mouse_over_tbox():
	mouse_over = true
	pass # Replace with function body.


func _on_TextBox_mouse_off_tbox():
	mouse_over = false
	pass # Replace with function body.


func _pressed(arg):
	current = dict[current]['options'][arg]['link']
	load_dialogue(current)
	pass
