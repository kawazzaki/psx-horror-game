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
@onready var camera_head := $fpsCam
@onready var collision_shape := $CollisionShape3D
@onready var raycast : RayCast3D = $fpsCam/RayCast3D


var rot_y := 0.0
var rot_x := 0.0
var is_mouse_captured := true
var is_crouching := false
var crouch_key_held := false
var speed := walk_speed

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
	detect_doors()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if(detect_doors() != null):
			detect_doors().open_or_close_door();


func _handle_input():
	
	if Input.is_key_pressed(run_key):
		speed = run_speed
	else:
		speed = walk_speed

	if Input.is_key_pressed(crouch_key):
		if not crouch_key_held:
			is_crouching = !is_crouching
			crouch_key_held = true
	else:
		crouch_key_held = false

	if is_crouching:
		speed = crouch_speed
		collision_shape.scale.y = collision_heights.x
	else:
		collision_shape.scale.y = collision_heights.y

	
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


func detect_doors():
	if(raycast.is_colliding()):
		var collider  = raycast.get_collider();
		if(collider.is_in_group("door")):
			return collider
		else:
			return null;
	else:
		return null;
	pass
