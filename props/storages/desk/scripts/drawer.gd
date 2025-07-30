extends StaticBody3D


@export var pickup_item : bool =false; # necessery
var isclosed = true;
@export var open_distance :float


#nodes
@onready var player_inventory = self.get_tree().root.get_child(0).get_node("player").get_node("inventory")


func spawn_item(item_name):
	if(item_name != ""):
		var item = player_inventory.items.get(item_name,null);
		if(item != null):
			var item_instance = item["scene"].instantiate();
			self.add_child(item_instance)
			item_instance.position = $item_pos.position;
			
			item_instance.item_name = item_name;
	
	pass


func interact():
	isclosed = !isclosed;
	var tween = get_tree().create_tween()
	$AudioStreamPlayer3D.play()
	if(isclosed):
		tween.tween_property(self,"position",Vector3(position.x,position.y,position.z-open_distance),0.5)
	else:
		tween.tween_property(self,"position",Vector3(position.x,position.y,position.z+open_distance),0.5)
	pass
