extends Node3D

var shake_force := 0.0
var shake_timer := 0.0
var shake_duration := 0.0
var original_transform: Transform3D

func _ready():
	original_transform = global_transform

func _process(delta: float) -> void:
	if shake_timer > 0.0:
		shake_timer -= delta
		var offset = Vector3(
			randf_range(-shake_force, shake_force),
			randf_range(-shake_force, shake_force),
			randf_range(-shake_force, shake_force) * 0.2 # أقل اهتزاز في العمق (Z)
		)
		global_transform.origin = original_transform.origin + offset
	else:
		global_transform.origin = original_transform.origin

func shake_camera(force: float, duration: float) -> void:
	shake_force = force
	shake_duration = duration
	shake_timer = duration
	original_transform = global_transform
