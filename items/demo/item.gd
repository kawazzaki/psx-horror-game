extends RigidBody3D;
class_name ITEM;

@export var object_name : String;
@export var pickup_item : bool = true;


func _ready():
	pass

func interact():
	if(pickup_item):
		print(self.name)
		queue_free()
	
	pass
