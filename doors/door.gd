extends StaticBody3D



@export var islocked = false;
@export var closed_angle : float;
@export var opened_angle : float;
@export var pickup_item : bool =false;
@export var key_name : String;


@onready var player_inventory : Node3D = get_tree().root.get_child(0).get_node("player").get_node("inventory")





var opende_for_first_time = false;
var isclosed : bool = true;


func _ready() -> void:

	self.rotation_degrees.y = closed_angle;
	

func _process(delta: float) -> void:
	
	if(!isclosed):
		islocked = false;
	else:
		if(opende_for_first_time == false):
			islocked = !check_player_if_has_the_key()
	
func check_player_if_has_the_key():
	for slot in player_inventory.items_in_inventory:
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
		print('this door is locked')
