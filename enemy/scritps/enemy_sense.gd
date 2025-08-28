extends Node3D


@onready var player= self.get_tree().root.get_child( self.get_tree().root.get_child_count() - 1).get_node("player");
@onready var cfr = self.get_tree().root.get_child( self.get_tree().root.get_child_count() - 1).get_node("cfr")
@onready var sfx = self.get_node("sense_sfx")

@export var CAO_curve = Curve.new()
@export var BM_curve = Curve.new()

func get_distance_to_player():
	return global_position.distance_to(player.global_position);

func _process(delta: float) -> void:
	if(get_parent().visible == true):
		#sfx.play()
		cfr.change_chromaticAberrationOffset(CAO_curve.sample(get_distance_to_player()) * 0.001)
		cfr.change_brightnessMult(BM_curve.sample(get_distance_to_player()))
	else:
		cfr.change_chromaticAberrationOffset(0.001)
		cfr.change_brightnessMult(2)
