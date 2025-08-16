extends event

func _ready():
	$MeshInstance3D.queue_free()
	disable_event()
	pass

func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		if(EventManager.start_event(event_index)):
			interact();
		pass
	pass # Replace with function body.

func interact():
	enable_event()
	$animation.play("event");
	EventManager.complete_event(event_index)
	pass



func player_move_possibility(value : bool):
	Global.player_can_move = value;
	pass

func disable_event():
	visible = false
	set_process(false)
	set_physics_process(false)
	$character.collision_layer = 0
	$character.collision_mask = 0


func enable_event(layer := 1, mask := 1):
	visible = true
	set_process(true)
	set_physics_process(true)
	$character.collision_layer = layer
	$character.collision_mask = mask

func turn_camera():
	Camera.change_camera($Camera3D,0.1)
	pass
func turn_camera_to_player():
	Camera.change_camera(null)
	pass


func start_dialog(dialog : String):
	Dialog.dialog_ui.start_dialog(dialog);
	pass
	
