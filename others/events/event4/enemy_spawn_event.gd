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
	$AnimationPlayer.play("event")
	Camera.change_camera($Camera3D)
	EventManager.complete_event(event_index);
	pass



func disable_event():
	visible = false
	set_process(false)
	set_physics_process(false)
	$enemy.collision_layer = 0
	$enemy.collision_mask = 0


func enable_event(layer := 1, mask := 1):
	visible = true
	set_process(true)
	set_physics_process(true)
	$enemy.collision_layer = layer
	$enemy.collision_mask = mask



func turn_camera_to_player():
	Camera.change_camera(null)
	pass
