extends StaticBody3D

@export var item_name : String;

@export var my_doors : Array[StaticBody3D];

@export var pickup_item : bool = true;

@onready var ground_checker : RayCast3D= $ground_checker;

var gravity_force = 0.2;

func interact():
	if(my_doors != []):
		for door in my_doors:
			door.islocked = false
	pass



func add_gravity(delta : float):
	
	pass


func _process(delta: float) -> void:
	self.global_position.y -= gravity_force;
	if(ground_checker.is_colliding()):
		if(ground_checker.get_collider().is_in_group("blocking")):
			gravity_force = 0;
		else:
			gravity_force = 0.05;
	else:
			gravity_force = 0.05;
