extends Node3D

@export var outline_mesh : MeshInstance3D;

var player_aim_raycast : RayCast3D ;

func _ready() -> void:
	outline_mesh.visible = false;
	player_aim_raycast = get_tree().root.get_child(1).get_node("player").get_node("head/fpsCam/aimChecker")

func _process(delta: float) -> void:
	
	if(player_aim_raycast != null):
		set_outline(is_aimed_by_raycast(player_aim_raycast))
		


func set_outline(value):
	outline_mesh.visible = value;
	pass

func is_aimed_by_raycast(raycast: RayCast3D) -> bool:
	if not raycast.is_colliding():
		return false
	var collider = raycast.get_collider()
	return collider == self.get_parent()
