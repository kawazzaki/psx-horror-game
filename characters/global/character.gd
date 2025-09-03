extends StaticBody3D


class_name character


@onready var player  =  get_tree().root.get_child(self.get_tree().root.get_child_count() - 1).get_node("player");



func _process(delta):
	if player:
		# get direction to player
		var dir = (player.global_transform.origin - global_transform.origin)
		dir.y = 0  # ignore vertical difference (only rotate on Y axis)
		look_at(global_transform.origin + dir, Vector3.UP)
