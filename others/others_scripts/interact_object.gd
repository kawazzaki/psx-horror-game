extends StaticBody3D



class_name interact_object


@onready var player_aim_raycast : RayCast3D =  get_tree().root.get_child(self.get_tree().root.get_child_count() - 1).get_node("player").get_node("head/fpsCam/aimChecker");
@export var press_indicator : Sprite3D

func _process(delta: float) -> void:
	if(press_indicator !=null):
		press_indicator.visible = is_aimed_by_raycast(player_aim_raycast)


func is_aimed_by_raycast(raycast: RayCast3D) -> bool:
	if not raycast.is_colliding():
		return false
	var collider = raycast.get_collider()
	return collider == self
