extends Node

# == References ==
#@onready var player_camera = self.get_tree().root.get_child(
#	self.get_tree().root.get_child_count() - 1
#).get_node("player").get_node("head/fpsCam")
var player_camera
# == Transition camera (وسيط) ==
var my_camera : Camera3D

func _ready():
	# نصنع كاميرا وسيطة
	my_camera = Camera3D.new()
	my_camera.current = false
	add_child(my_camera)


# == Change camera ==
# target_cam = الكاميرا الهدف (إذا null → يرجع للاعب)
# time = مدة الانتقال بالثواني
func change_camera(target_cam : Camera3D, time := 0.5):
	var tween = get_tree().create_tween()
	my_camera.global_position = player_camera.global_position
	my_camera.global_rotation = player_camera.global_rotation
	my_camera.current = true

	if target_cam != null:
		# الانتقال من player → target_cam
		tween.tween_property(my_camera, "global_position", target_cam.global_position, time)
		tween.tween_property(my_camera, "global_rotation", target_cam.global_rotation, time)
		tween.finished.connect(func(): _on_tween_finished(target_cam))
	else:
		# الانتقال من cutscene → player
		tween.tween_property(my_camera, "global_position", player_camera.global_position, time)
		tween.tween_property(my_camera, "global_rotation", player_camera.global_rotation, time)
		tween.finished.connect(func(): _on_tween_finished(player_camera))


# == Callback عند انتهاء الـ tween ==
func _on_tween_finished(cam : Camera3D):
	cam.current = true
	print("Tween finished! Now active camera:", cam.name)
