extends event


func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		if(EventManager.start_event(event_index)):
			interact();
		pass


func interact():
	$AnimationPlayer.play("event");
	


func finish_event():
	EventManager.complete_event(event_index)
