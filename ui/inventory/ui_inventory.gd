extends Control

@export var inventory_key : Key = KEY_TAB

var is_appared = false
var hold_key_pressing = false

# استيراد العقد
@onready var player : CharacterBody3D = get_tree().root.get_child(0).get_node("player")
@export var slots : Array[Control]  # يجب أن يكون فيها نفس عدد خانات الإنفنتوري

func _process(delta: float) -> void:
	handle_inventory_toggle()
	if is_appared:
		render_inventory()

func _on_button_pressed() -> void:
	is_appared = false

func handle_inventory_toggle():
	if Input.is_key_pressed(inventory_key):
		if not hold_key_pressing:
			is_appared = !is_appared
			Global.toggle_mouse()
			if(is_appared):
				$AudioStreamPlayer3D.play()
			hold_key_pressing = true
	else:
		hold_key_pressing = false
	self.visible = is_appared

func render_inventory():
	for i in Global.items_in_inventory.size():
		var inventory_item = Global.items_in_inventory[i]

		var tex : TextureRect = slots[i].get_node("texture")
		var name : Label = slots[i].get_node("item_name")

		if inventory_item != "" and Global.has_item(inventory_item):
			var icon_texture = Global.get_item_icon(inventory_item)
			tex.texture = icon_texture
			name.text = inventory_item
		else:
			tex.texture = null
			name.text = ""
