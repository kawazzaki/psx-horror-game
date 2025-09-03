extends Node

signal dialogue_finished

# === Nodes (set dynamically) ===
var dialog_ui: Control = null
var dialog_label: Label = null
var speaker_label: Label = null
var type_timer: Timer = null

# === Dialogue data ===
var dialogues = {}
var current_dialogue = []
var dialogue_index = 0
var current_dialogue_id = ""

# === Typewriter effect ===
var full_text = ""
var char_index = 0
var is_typing = false


# === Registration ===
func register_dialog_ui(ui_node: Control):
	dialog_ui = ui_node
	dialog_label = dialog_ui.get_node("Label1")
	speaker_label = dialog_ui.get_node("Label0")
	type_timer = dialog_ui.get_node("Timer")
	if type_timer:
		type_timer.timeout.connect(_on_TypeTimer_timeout)
	dialog_ui.visible = false


# === Load dialogues ===
func load_dialogues():
	var file = FileAccess.open("res://others/dialogues.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		dialogues = JSON.parse_string(content)
		file.close()


# === Start dialogue ===
func start_dialogue(dialogue_id: String):
	if dialogues.has("dialogs") and dialogues["dialogs"].has(dialogue_id):
		current_dialogue = dialogues["dialogs"][dialogue_id]
		current_dialogue_id = dialogue_id
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
		Global.player_can_move = false
		type_timer.start()
	else:
		end_dialogue()


func next_line():
	if is_typing:
		dialog_label.text = full_text
		is_typing = false
		type_timer.stop()
	else:
		dialogue_index += 1
		show_line()


func _on_TypeTimer_timeout():
	if char_index < full_text.length():
		dialog_label.text += full_text[char_index]
		char_index += 1
		dialog_ui.get_node("AudioStreamPlayer").play()
	else:
		is_typing = false
		type_timer.stop()


func end_dialogue():
	Global.toggle_mouse()
	dialog_ui.visible = false
	dialog_label.text = ""
	speaker_label.text = ""
	current_dialogue = []
	dialogue_index = 0
	print("Dialogue finished!")
	emit_signal("dialogue_finished", current_dialogue_id)
	current_dialogue_id = ""
