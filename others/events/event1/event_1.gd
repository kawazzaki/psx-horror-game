extends event








func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		if(EventManager.start_event(event_index)):
			interact();
		pass
	pass # Replace with function body.

func interact():
	EventManager.complete_event(event_index);
	pass
