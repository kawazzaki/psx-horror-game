extends RigidBody3D;
class_name ITEM;

@export var item_name : String;
@export var pickup_item : bool = true;


func _ready():
	pass

func interact():
	print(self.name)
	pass
