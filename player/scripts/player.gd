extends CharacterBody3D


@export var walk_speed: float = 5.0
@export var run_speed: float = 10.0
@export var crouch_speed: float = 2.5
@export var mouse_sensitivity: float = 0.2
@export var collision_heights := Vector2(0.5, 1.0) # x=crouch, y=stand

@export var run_key: Key = KEY_SHIFT
@export var crouch_key: Key = KEY_C
@export var toggle_mouse_key: Key = KEY_V

# == Nodes ==
@onready var camera_head := $head/fpsCam
@onready var head = $head
@onready var collision_shape := $CollisionShape3D
@onready var aim_raycast : RayCast3D = $head/fpsCam/aimChecker
@onready var crouch_raycast : RayCast3D = $head/crouchChecker
@onready var inventory : Node3D = $inventory

var rot_y := 0.0
var rot_x := 0.0
var is_mouse_captured := true
var is_crouching := false
var crouch_key_held := false
var speed := walk_speed
var breathing_period = 0;
var aim_collider ;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and is_mouse_captured:
		rot_y -= event.relative.x * mouse_sensitivity
		rot_x -= event.relative.y * mouse_sensitivity
		rot_x = clamp(rot_x, -90, 90)
		rotation_degrees.y = rot_y
		camera_head.rotation_degrees.x = rot_x

	elif event is InputEventKey and event.pressed and event.keycode == toggle_mouse_key:
		_toggle_mouse()

func _toggle_mouse():
	is_mouse_captured = !is_mouse_captured
	Input.set_mouse_mode(
		Input.MOUSE_MODE_CAPTURED if is_mouse_captured else Input.MOUSE_MODE_VISIBLE
	)

func _physics_process(delta):
	_handle_input()
	apply_gravity(delta)
	move_and_slide()
	set_interact_object_outline()
	breathing_effect(delta)
	


func _input(event):
	if(event is InputEventMouseMotion):
		detect_interact_object()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swap_inventory_item()


func _handle_input():
	
	if Input.is_key_pressed(run_key):
		speed = run_speed
	else:
		speed = walk_speed

	if Input.is_key_pressed(crouch_key):
		if not crouch_key_held:
			if(is_crouching == true):
				if(standing_possibility()):
					is_crouching = false
				else:
					print("cant stand")
			else:
				is_crouching = true
			crouch_key_held = true
			
	else:
		crouch_key_held = false
	
	if is_crouching:
		speed = crouch_speed
		var tween = get_tree().create_tween()
		tween.tween_property(collision_shape,"scale",Vector3(collision_shape.scale.x,collision_heights.x,collision_shape.scale.z),0.5)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(collision_shape,"scale",Vector3(collision_shape.scale.x,collision_heights.y,collision_shape.scale.z),0.5)

	
	var dir := Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x

	dir = dir.normalized()
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		velocity.y = 0.0


func detect_interact_object():
	if aim_raycast.is_colliding():
		var collider = aim_raycast.get_collider()
		if collider != null and collider.is_in_group("interact"):
			aim_collider = collider
			return collider
	return null
	
func set_interact_object_outline():
	if(detect_interact_object() == null):
		if(aim_collider == null):
			pass
		else:
			aim_collider.get_node("outline").set_outline(false);
			aim_collider = null;
	else:
		detect_interact_object().get_node("outline").set_outline(true)
	pass



func breathing_effect(delta):
	breathing_period += delta

	
	var intensity = speed / 50         
	var frequency = 1.0 + (speed / 10.0)   

	var breathing_offset = sin(breathing_period * frequency) * intensity
	head.position.y = 1 + breathing_offset

func standing_possibility():
	return !crouch_raycast.is_colliding();

func swap_inventory_item():
	if(detect_interact_object() != null && is_mouse_captured):
		detect_interact_object().interact();
		var slot_index = inventory.check_if_inventory_full();
		if(slot_index == -1):
			print("inventory is full")
		else:
			if(detect_interact_object().pickup_item == true):
				inventory.items_in_inventory[slot_index] = detect_interact_object().item_name;


#
#if(detect_interact_object() != null):
#		detect_interact_object().interact();
#		if(detect_interact_object().pickup_item == true):
#			var object  = detect_interact_object();
#			if(inventory.item_in_inventory != ""):
#				var item_data = inventory.get_item_by_name()
#				var item_scene = item_data.get("scene", null)
#				if item_scene != null:
#					var item_instance = item_scene.instantiate()
#					item_instance.global_position = self.global_position 
#					get_tree().current_scene.add_child(item_instance)
#					item_instance.item_name = inventory.item_in_inventory;
#			inventory.item_in_inventory = object.item_name;
#			object.queue_free();


func drop_item(item_name):
	var item_to_drop = inventory.items.get(item_name,null);
	if(item_to_drop != null):
		var item_instance = item_to_drop["scene"].instantiate();
		item_instance.global_position = self.global_position + Vector3(1,0,0); 
		get_tree().current_scene.add_child(item_instance)
		item_instance.item_name = item_name;
	
	pass
