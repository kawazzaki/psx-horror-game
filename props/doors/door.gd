extends StaticBody3D


@export var object_name : String;

@export var islocked = false;
var closed_angle : float;
var opened_angle : float;
@export var pickup_item : bool =false; # necessery
@export var key_name : String;
@export var variation_angle : float;






var opende_for_first_time = false;
var isclosed : bool = true;


func _ready() -> void:
	closed_angle = self.rotation_degrees.y;
	opened_angle = closed_angle + variation_angle
	

func check_player_if_has_the_key():
	for slot in Global.items_in_inventory:
		if(slot == key_name):
			opende_for_first_time = true
			return true;
	return false

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
		if(check_player_if_has_the_key() == true):
			islocked = false;
		pass
		
	
