extends Node


#inventory-system(new)

var items_in_inventory : Array[String] = ["","",""];

@onready var inventory = self.get_tree().root.get_child(1).get_node("player").get_node("inventory")


var items = {}

func _ready():
	var file = FileAccess.open("res://others/items.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if typeof(json) == TYPE_DICTIONARY:
			items = json


func has_item(item_name: String) -> bool:
	return item_name in items

func get_item_scene(item_name: String) -> PackedScene:
	if has_item(item_name):
		return load(items[item_name]["scene_path"])
	return null

func get_item_icon(item_name: String) -> Texture2D:
	if has_item(item_name):
		return load(items[item_name]["icon_path"])
	return null

func check_if_inventory_full():
	for i in items_in_inventory.size():
		if(items_in_inventory[i]== ""):
			return i;
	return -1;
	pass
	
	
#mouse_capture
var is_mouse_captured := true
func toggle_mouse():
	Global.is_mouse_captured = !Global.is_mouse_captured
	Input.set_mouse_mode(
		Input.MOUSE_MODE_CAPTURED if Global.is_mouse_captured else Input.MOUSE_MODE_VISIBLE
	)
