extends Node3D



var item_in_inventory = "";


func _process(delta: float) -> void:
	print(item_in_inventory)



#items database
var items = {
	"door key2" : {
		"scene": preload("res://items/key/key.tscn"),
	},
	"door key1" : {
		"scene": preload("res://items/key/key.tscn"),
	},
}


func get_item_by_name():
	return items.get(item_in_inventory,{})
