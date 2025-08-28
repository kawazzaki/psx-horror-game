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
	enable_event(1,1)
	$AnimationPlayer.play("event")
	
	pass

func finish_animation():
	EventManager.complete_event(event_index);
	self.queue_free()
	pass


func disable_event():
	visible = false
	set_process(false)
	set_physics_process(false)
	$enemy.visible = false
	$enemy.collision_layer = 0
	$enemy.collision_mask = 0


func enable_event(layer := 1, mask := 1):
	visible = true
	set_process(true)
	set_physics_process(true)
	$enemy.visible = true
	$enemy.collision_layer = layer
	$enemy.collision_mask = mask
