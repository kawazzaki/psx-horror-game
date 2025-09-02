extends Area3D
class_name Event

@onready var player: CharacterBody3D  = get_tree().root.get_child(self.get_tree().root.get_child_count() - 1).get_node("player")

@export_enum("Enabled", "Disabled")
var succesive_event: String = "Enabled"
@export var index = 0;

func _start():
	pass
func _ready():
	_start();
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func check_succesive_event():
	if (succesive_event == "Disabled"):
		interact()
		
	else:
		if(EventManager.start_event(index)):
			interact()



func _on_body_entered(body: CharacterBody3D) -> void:
	if body == player:
		check_succesive_event()
		print("Player entered the area!")

func _on_body_exited(body: CharacterBody3D) -> void:
	if body == player:
		print("Player exited the area!")

func interact():
	print("start event : " + str(index))
	pass
