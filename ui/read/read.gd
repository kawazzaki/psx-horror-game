extends Control


func _ready() -> void:
	self.visible = false

func _on_exit_pressed() -> void:
	Global.toggle_mouse()
	self.visible = false
	pass # Replace with function body.
