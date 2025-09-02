extends Event





func _start():
	set_customer_propreties(0,false);
	DialogSys.dialogue_finished.connect(_on_dialogue_finished)


func interact():
	$AnimationPlayer.play("event0")



func set_customer_propreties(collision_layer : int , visibility : bool):
	$customer.collision_layer = collision_layer;
	$customer.visible = visibility


func change_cam(new_cam : bool):
	if (new_cam == true):
		Camera.change_camera($Camera3D,0.15)
	else:
		Camera.change_camera(null,0.4)
	pass

func start_event_dilaog(dialog_name : String):
	DialogSys.start_dialogue(dialog_name)
	pass


func _on_dialogue_finished(dialogue_id):
	if dialogue_id == "customer1":
		$AnimationPlayer.play("event1")
		#change_cam(true)
	if dialogue_id == "customer0":
		$AnimationPlayer.play("event")
		#change_cam(true)
	


func move_to_next_animation(animation_name : String):
	$AnimationPlayer.play(animation_name)
	pass
