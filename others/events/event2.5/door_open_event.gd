extends event

@export var door : StaticBody3D;

func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		if(EventManager.start_event(event_index)):
			interact();
		pass
	pass # Replace with function body.

func interact():
	$AudioStreamPlayer3D.play()
	door.open_or_close_door();
	EventManager.complete_event(event_index);
	pass
