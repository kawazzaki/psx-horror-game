extends Control




@onready var txt_input = $codeInput
@export var machine : StaticBody3D;
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	self.visible = false;

func _on_button_pressed() -> void:
	if(Global.show_paper("pc_password") == txt_input.text):
		self.visible = false;
		machine.first_animation();
		machine.first_time = false
		Global.toggle_mouse()
	else:
		print('not the same password')
	pass # Replace with function body.


func _on_btn_exit_pressed() -> void:
	self.visible = false;
	Global.toggle_mouse()


func _unhandled_input(event):
	if(self.visible == true):
		audio_player.play()
