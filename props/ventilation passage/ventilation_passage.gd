extends interact_object

@export var object_name : String;
@export var pickup_item : bool =false; # necessery
@export var interact_item:String;


func interact():
	if(Global.check_item_is_in_inventory(interact_item)):
		self.get_parent().get_node("AnimationPlayer").play("open")
	else:
		print("need screw remover")
