extends StaticBody3D



@export var islocked = false;
@export var closed_angle : float;
@export var opened_angle : float;



var isclosed : bool = true;

func _ready() -> void:
	self.rotation_degrees.y = closed_angle;




func interact():
	isclosed = !isclosed;
	if (isclosed == true):
		var tween = get_tree().create_tween()
		tween.tween_property(self,"rotation_degrees",Vector3(rotation_degrees.x,closed_angle,rotation_degrees.z),0.5)
		pass
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"rotation_degrees",Vector3(rotation_degrees.x,opened_angle,rotation_degrees.z),0.5)
		pass
	pass
