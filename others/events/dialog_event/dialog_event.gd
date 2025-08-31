extends Event

@export var dialog_name : String ;


func interact():
	DialogSys.start_dialogue(dialog_name)
	pass
