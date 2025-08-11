extends Area3D

class_name event;
@export var event_index : int;
#
#@export_enum("start", "create")
#var state_of_event: String
#
#@export var event_engine : Node3D
#
#@export_group("for_create_animation")
#@export var create_position : Vector3
#@export var event_scene : PackedScene
#
func _ready():
	$MeshInstance3D.queue_free()


#func _on_body_entered(body: Node3D) -> void:
	#if state_of_event == "start":
		#start_event(body)
	#elif state_of_event == "create":
		#create_event()
#
#func create_event():
	#if event_scene:
		#var instance = event_scene.instantiate()
		#instance.position = create_position
		#get_parent().add_child(instance)
		#self.queue_free() # Remove this node after creation
	#else:
		#push_warning("No event_scene assigned!")
#
#func start_event(body):
	#if body.is_in_group("player"):
		#var animator = event_engine.get_node("AnimationPlayer")
		#animator.play("event1")
		#event_engine.interact(body)
		#self.queue_free()
