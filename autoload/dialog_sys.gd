extends Node

# == Nodes ==
@onready var dialog_ui = get_tree().root.get_child(get_tree().root.get_child_count() - 1).get_node("dialog")
@onready var dialog_label = dialog_ui.get_node("Label1")
@onready var speaker_label = dialog_ui.get_node("Label0")
@onready var type_timer = dialog_ui.get_node("Timer")

# == Dialogue data ==
var dialogues = {}
var current_dialogue = []
var dialogue_index = 0

# == Typewriter effect ==
var full_text = ""
var char_index = 0
var is_typing = false

func _ready():
	if type_timer:
		type_timer.timeout.connect(_on_TypeTimer_timeout)
	load_dialogues()
	dialog_ui.visible = false   # واجهة الحوار مخفية عند البداية

func load_dialogues():
	var file = FileAccess.open("res://others/dialogues.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		dialogues = JSON.parse_string(content)   # Godot 4
		file.close()

func start_dialogue(dialogue_id: String):
	if dialogues.has("dialogs") and dialogues["dialogs"].has(dialogue_id):
		current_dialogue = dialogues["dialogs"][dialogue_id]
		dialogue_index = 0
		dialog_ui.visible = true
		Global.toggle_mouse()
		show_line()
	else:
		print("Dialogue ID not found:", dialogue_id)

func show_line():
	if dialogue_index < current_dialogue.size():
		var line = current_dialogue[dialogue_index]
		speaker_label.text = line["speaker"] + " :"
		full_text = line["text"]
		char_index = 0
		dialog_label.text = ""
		is_typing = true
		Global.player_can_move = false   # اللاعب يتوقف أثناء الحوار
		type_timer.start()
	else:
		end_dialogue()

func next_line():
	if is_typing:
		# إذا الكتابة لم تنتهي → أكمل النص مباشرة
		dialog_label.text = full_text
		is_typing = false
		type_timer.stop()
	else:
		# انتقل للسطر التالي
		dialogue_index += 1
		show_line()

func _on_TypeTimer_timeout():
	if char_index < full_text.length():
		dialog_label.text += full_text[char_index]
		char_index += 1
		dialog_ui.get_node("AudioStreamPlayer").play()
	else:
		is_typing = false
		#Global.player_can_move = true
		type_timer.stop()

func end_dialogue():
	Global.toggle_mouse()
	dialog_ui.visible = false
	dialog_label.text = ""
	speaker_label.text = ""
	current_dialogue = []
	dialogue_index = 0
	#Global.player_can_move = true
	print("Dialogue finished!") 
