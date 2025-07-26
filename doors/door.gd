extends StaticBody3D



@export var islocked = false;
@export var closed_angle : float;
@export var opened_angle : float;
@export var pickup_item : bool =false;


var isclosed : bool = true;

func _ready() -> void:
	self.rotation_degrees.y = closed_angle;




func interact():
	if(!islocked):
		isclosed = !isclosed;
		var tween = get_tree().create_tween()
		if (isclosed == true):
			tween.tween_property(self,"rotation_degrees",Vector3(rotation_degrees.x,closed_angle,rotation_degrees.z),0.5)
			pass
		else:
			tween.tween_property(self,"rotation_degrees",Vector3(rotation_degrees.x,opened_angle,rotation_degrees.z),0.5)
	else:
		print('this door is locked')
