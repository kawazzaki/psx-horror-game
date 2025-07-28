extends Control



var item_name = "" ;
@export var index = 0;

#nodes
@onready var player = self.get_tree().root.get_child(0).get_node("player")
@onready var inventory_core = self.get_tree().root.get_child(0).get_node("player").get_node("inventory");

func _process(delta: float) -> void:
	
	if(inventory_core.items_in_inventory[index] == ""):
		self.get_node("item_name").text = "empty"
	else:
		item_name =  self.get_node("item_name").text
	
	
	
func _on_button_pressed() -> void:
	player.drop_item(item_name)
	set_empty()
	
	
func set_empty():
	inventory_core.items_in_inventory[index] = ""
	item_name = ""
	self.get_node("texture").texture = load("res://icon.svg")
	pass
