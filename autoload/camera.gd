extends Node

@onready var player_camera = self.get_tree().root.get_child( self.get_tree().root.get_child_count() - 1).get_node("player").get_node("head/fpsCam")

var my_camera : Camera3D;
func _ready():
	# Create the camera
	my_camera = Camera3D.new()
	
	# Set position and rotation
	my_camera.global_position = player_camera.global_position
	my_camera.look_at(Vector3(0, 0, 0))
	
	# Make it the active camera
	my_camera.current = false
	
	# Add it to the scene
	add_child(my_camera)

func change_camera(new_cam : Camera3D , time := 0.5):
	var tween = get_tree().create_tween()
	if(new_cam != null):
		my_camera.global_position = player_camera.global_position;

	else:
		pass
	
	my_camera.current = true;
	if(new_cam != null):
		tween.tween_property(my_camera,"global_position",new_cam.global_position,time);
		tween.tween_property(my_camera,"global_rotation",new_cam.global_rotation,time);
		tween.finished.connect(func(): _on_tween_finished(new_cam)) # works in latest Godot
	else:
		tween.tween_property(my_camera,"global_position",player_camera.global_position,time);
		tween.tween_property(my_camera,"global_rotation",player_camera.global_rotation,time);
		tween.finished.connect(func(): _on_tween_finished(player_camera)) # works in latest Godot
	

func _on_tween_finished(cam : Camera3D):
	cam.current = true;
	print("Tween finished!")
