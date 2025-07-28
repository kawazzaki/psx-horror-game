extends Control


@export var inventory_key : Key = KEY_TAB;


var is_appared = false;
var hold_key_pressing = false;


#import nodes
@onready var player : CharacterBody3D = get_tree().root.get_child(0).get_node("player")
@export var slots : Array[Control];
var inventory : Node3D;


func _ready() -> void:
	inventory = player.get_node("inventory")


func _process(delta: float) -> void:
	handle_inventory_toggle();
	if(is_appared):
		render_inventory();

func _on_button_pressed() -> void:
	is_appared = false

func handle_inventory_toggle():
	if Input.is_key_pressed(inventory_key):
		if(not hold_key_pressing):
			is_appared = !is_appared;
			hold_key_pressing = true;
	else:
		hold_key_pressing = false
	self.visible = is_appared
	

func render_inventory():
	for i in inventory.items_in_inventory.size():
		var inventory_item = inventory.items_in_inventory[i];
		if(inventory_item != ""):
			var item = inventory.items.get(inventory_item,null)
			var tex : TextureRect = slots[i].get_node("texture")
			var name : Label = slots[i].get_node("item_name")
			tex.texture = item.get("icon")
			name.text = inventory_item
