extends Sprite3D



@onready var player  =  get_tree().root.get_child(self.get_tree().root.get_child_count() - 1).get_node("player").get_node("head/fpsCam");


func _process(delta: float) -> void:

	self.look_at(player.global_transform.origin)
	pass
