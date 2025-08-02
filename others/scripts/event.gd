extends Area3D


@export var event_engine : Node3D


func _ready():
	$MeshInstance3D.queue_free()
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		event_engine.get_node("AnimationPlayer").play("event1")
		event_engine.interact(body);
		self.queue_free()
		pass
		#test shader chnage parametre
		#var cfr = self.get_tree().root.get_child(1).get_node("cfr");
		#cfr.change_chromaticAberrationOffset(0.01)
	pass # Replace with function body.
