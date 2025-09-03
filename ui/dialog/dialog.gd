extends Control

@onready var dialog_label = self.get_node("Label1")
@onready var speaker_label = self.get_node("Label0")
@onready var type_timer = self.get_node("Timer")

func _ready() -> void:

	DialogSys.register_dialog_ui(self)
	DialogSys.load_dialogues()


func _on_button_pressed() -> void:
	DialogSys.next_line()
	
	pass 
