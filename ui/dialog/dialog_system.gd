extends Control


var index := 0
var current_dialog := ""
@onready var timer: Timer = $Timer
@onready var dialog_label: Label = $Label  # أو RichTextLabel


func _ready():
	start_dialog("")
	pass

func start_dialog(text: String) -> void:
	current_dialog = text
	index = 0
	dialog_label.text = ""
	timer.start()

func _on_timer_timeout() -> void:
	if index < current_dialog.length():
		dialog_label.text += current_dialog.substr(index, 1)
		index += 1
	else:
		timer.stop()
