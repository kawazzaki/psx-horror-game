extends Node3D


var update_dis = 0;

var _player = null


@export var max_dis : float;
@export var chromaticAberration_curve := Curve.new()
@export var brightnessMult_curve := Curve.new()

@onready var cfr_fx = self.get_tree().root.get_child(1).get_node("cfr");

func _process(delta: float) -> void:
	calcul_distance()
	pass
#

func calcul_distance():
	if(_player != null):
		update_dis = self.get_node("body").global_position.distance_to(_player.global_position);
		cfr_fx.change_chromaticAberrationOffset(chromaticAberration_curve.sample(update_dis) * 0.01);
		cfr_fx.change_brightnessMult(brightnessMult_curve.sample(update_dis));
		if($AnimationPlayer.is_playing()):
			if(update_dis < 1):
				$AnimationPlayer.pause()
			else:
				$AnimationPlayer.play()

func interact(player : CharacterBody3D):
	_player = player
	calcul_distance()

	pass
