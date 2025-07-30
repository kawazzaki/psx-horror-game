extends StaticBody3D



var drawers_in_storage = []

@export var items_in_drawers : Array[String]


func _ready():
	for obj in self.get_children():
		if(obj.is_in_group("drawer")):
			drawers_in_storage.append(obj)
	print(self.name + " " + str(drawers_in_storage.size()))
	
	for i in items_in_drawers.size():
		drawers_in_storage[i].spawn_item(items_in_drawers[i])
		pass
	pass
