extends ITEM



#@export var item_name : String;

@export var my_doors : Array[StaticBody3D];

#@export var pickup_item : bool = true;


func interact():
	queue_free()
	pass
