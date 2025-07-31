extends Control



var item_name = "" ;
@export var index = 0;

#nodes
@onready var player = self.get_tree().root.get_child(1).get_node("player")


func _process(delta: float) -> void:
	
	if(Global.items_in_inventory[index] == ""):
		self.get_node("item_name").text = "empty"
	else:
		item_name =  self.get_node("item_name").text
	
	
	

func set_empty():
	Global.items_in_inventory[index] = ""
	item_name = ""
	self.get_node("texture").texture = load("res://icon.svg")
	pass


func _on_button_pressed() -> void:
	player.drop_item("key1")
	set_empty()
