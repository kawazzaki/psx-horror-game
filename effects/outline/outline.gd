extends Node3D

@export var outline_mesh : MeshInstance3D;

func _ready() -> void:
	outline_mesh.visible = false;
	pass

func set_outline(value):
	outline_mesh.visible = value;
	pass
