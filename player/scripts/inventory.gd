extends Node3D



var items_in_inventory : Array[String] = ["","",""];




func check_if_inventory_full():
	for i in items_in_inventory.size():
		if(items_in_inventory[i]== ""):
			return i;
	return -1;
	pass

#items database
var items = {
	"key1" : {
		"scene": preload("res://items/key/key.tscn"),
		"icon": preload("res://demo/PNG/Dark/texture_01.png")
	},
	"key2" : {
		"scene": preload("res://items/key/key.tscn"),
		"icon": preload("res://demo/PNG/Green/texture_01.png")
	},
}
