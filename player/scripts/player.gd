extends CharacterBody3D


@export var walk_speed: float = 5.0
@export var run_speed: float = 10.0
@export var crouch_speed: float = 2.5
@export var mouse_sensitivity: float = 0.2
@export var collision_heights := Vector2(0.5, 1.0) # x=crouch, y=stand

@export var run_key: Key = KEY_SHIFT
@export var crouch_key: Key = KEY_C
@export var toggle_mouse_key: Key = KEY_V

@export var walk_sound_fx : AudioStream;

# == Nodes ==
@onready var camera_head := $head/fpsCam
@onready var head = $head
@onready var collision_shape := $CollisionShape3D
@onready var aim_raycast : RayCast3D = $head/fpsCam/aimChecker
@onready var crouch_raycast : RayCast3D = $head/crouchChecker
#@onready var inventory : Node3D = $inventory
@onready var sound_output : AudioStreamPlayer3D = $foot_step_s


var rot_y := 0.0
var rot_x := 0.0

var is_crouching := false
var crouch_key_held := false
var speed := walk_speed
var breathing_period = 0;
var aim_collider ;
var slot_index ;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and Global.is_mouse_captured:
		rot_y -= event.relative.x * mouse_sensitivity
		rot_x -= event.relative.y * mouse_sensitivity
		rot_x = clamp(rot_x, -90, 90)
		rotation_degrees.y = rot_y
		camera_head.rotation_degrees.x = rot_x

	elif event is InputEventKey and event.pressed and event.keycode == toggle_mouse_key:
		Global.toggle_mouse()


func _physics_process(delta):
	if(Global.player_can_move):
		_handle_input()
		apply_gravity(delta)
		move_and_slide()
		breathing_effect(delta)
		detect_interact_object()
		update_footstep_timer()
		print(standing_possibility())
		slot_index = Global.check_if_inventory_full();


func _input(event):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swap_inventory_item()


func _handle_input():
	
	if Input.is_key_pressed(run_key):
		speed = run_speed
	else:
		speed = walk_speed

	if Input.is_key_pressed(crouch_key) :
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
		tween.tween_property(collision_shape,"scale",Vector3(collision_shape.scale.x,collision_heights.x,collision_shape.scale.z),0.2)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(collision_shape,"scale",Vector3(collision_shape.scale.x,collision_heights.y,collision_shape.scale.z),0.2)

	
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
		aim_collider = null
	aim_collider = null
	return null
	

func breathing_effect(delta):
	breathing_period += delta

	
	var intensity = speed / 50         
	var frequency = 1.0 + (speed / 10.0)   

	var breathing_offset = sin(breathing_period * frequency) * intensity
	head.position.y = 1 + breathing_offset

func standing_possibility():
	return !crouch_raycast.is_colliding();

func swap_inventory_item():
	if(aim_collider != null && Global.is_mouse_captured == true):
		if(aim_collider.pickup_item == false):
			aim_collider.interact();
		if(slot_index == -1):
			print("inventory is full")
		else:
			if(aim_collider.pickup_item == true):
				aim_collider.interact();
				Global.items_in_inventory[slot_index] = aim_collider.object_name;


#old system :/
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
	if Global.has_item(item_name):
		var item_scene = Global.get_item_scene(item_name)
		if item_scene != null:
			var item_instance = item_scene.instantiate()
			item_instance.global_position = self.global_position + Vector3(1, 0, 0)
			get_tree().current_scene.add_child(item_instance)
			item_instance.object_name = item_name
		else:
			print("Failed to load scene for item:", item_name)
	else:
		print("Item not found in database:", item_name)

func update_footstep_timer():
	if(speed == run_speed):
		$Timer.wait_time = 0.28
	elif(speed == walk_speed):
		$Timer.wait_time = 0.65

func _on_timer_timeout() -> void:
	if(velocity != Vector3.ZERO && is_crouching == false):
		sound_output.stream = walk_sound_fx
		sound_output.play()
	pass # Replace with function body.
