extends Control


func _on_exit_pressed() -> void:
	Global.toggle_mouse()
	self.visible = false
	pass # Replace with function body.
