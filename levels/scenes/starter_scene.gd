extends Node3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	DialogSys.dialogue_finished.connect(_on_dialogue_finished)


func _start_dialog(dialog_id : String):
	DialogSys.start_dialogue(dialog_id)
	pass

func _on_dialogue_finished(dialogue_id):
	if dialogue_id == "agent13_p1":
		$AnimationPlayer.play("cutscene1")
	if dialogue_id == "agent13_p2":
		$AnimationPlayer.play("cutscene2")
		
		pass


func _fade_out():
	Fade.fade_out(1)


func _fade_in():
	Fade.fade_in(3)

func change_scene():
	get_tree().change_scene_to_file("res://levels/scenes/starter_house.tscn")
