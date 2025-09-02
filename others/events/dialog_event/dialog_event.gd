extends Event

@export var dialog_name : String ;


@export var event_camera : Camera3D;

func _start():
	DialogSys.dialogue_finished.connect(_on_dialogue_finished)
	pass

func interact():
	if(event_camera != null):
		Camera.change_camera(event_camera,0.25)
		pass
	DialogSys.start_dialogue(dialog_name)
	pass

func _on_dialogue_finished(dialogue_id):
	if dialogue_id == "ali":
		Camera.change_camera(null)
