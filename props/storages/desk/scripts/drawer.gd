extends StaticBody3D


@export var pickup_item : bool =false; # necessery
var isclosed = true;
@export var open_distance :float


func interact():
	isclosed = !isclosed;
	var tween = get_tree().create_tween()
	if(isclosed):
		tween.tween_property(self,"position",Vector3(position.x,position.y,position.z-open_distance),0.5)
	else:
		tween.tween_property(self,"position",Vector3(position.x,position.y,position.z+open_distance),0.5)
	pass
