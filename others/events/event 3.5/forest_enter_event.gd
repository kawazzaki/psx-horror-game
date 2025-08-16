extends event


@export var border : StaticBody3D;

func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		if(EventManager.start_event(event_index)):
			interact();
		pass
	pass # Replace with function body.

func interact():
	#$animation.play("event");
	border.get_node("CollisionShape3D").disabled = false;
	border.visible = true;
	EventManager.complete_event(event_index)
	pass



func player_move_possibility(value : bool):
	Global.player_can_move = value;
	pass


func turn_camera():
	Camera.change_camera($Camera3D,0.1)
	pass
func turn_camera_to_player():
	Camera.change_camera(null)
	pass
