extends Node


#inventory-system(new)

var items_in_inventory : Array[String] = ["","",""];

@onready var head= self.get_tree().root.get_child(1).get_node("player").get_node("head/fpsCam")




var items = {}

func _ready():
	var file = FileAccess.open("res://others/items.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if typeof(json) == TYPE_DICTIONARY:
			items = json
	load_papers()


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
	
#paper_read_system
var papers_data = {}


func load_papers():
	var file = FileAccess.open("res://others/papers.json", FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.parse_string(json_string)
	if json != null:
		papers_data = json
	else:
		push_error("Failed to parse papers.json")

func show_paper(paper_id: String):
	if papers_data.has(paper_id):
		var paper = papers_data[paper_id]
		#$TitleLabel.text = paper["title"]
		#$ContentLabel.text = paper["content"]
		return paper["content"]
	else:
		push_error("Paper not found: " + paper_id)
		return "nothing"
		


#information sub-title
@onready var sub_title = self.get_tree().root.get_child(1).get_node("sub-title")
@onready var aim_collider  = self.get_tree().root.get_child(1).get_node("player").aim_collider

func _process(delta: float) -> void:
	if(!aim_collider):
		sub_title.text = ""
	pass
