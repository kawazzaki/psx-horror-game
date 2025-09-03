extends Event


@export var cutscene_cam : Camera3D;

func interact():
	$AnimationPlayer.play("event")
	pass


func change_camera(cam : bool):
	if cam == true :
		Camera.change_camera(cutscene_cam,0)
	else:
		Camera.change_camera(null)
	pass
