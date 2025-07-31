extends StaticBody3D

@export var object_name : String;


@export var pickup_item : bool =false; # necessery

var machine_state = "off";

var material : StandardMaterial3D;

@export var texture : Texture;
@onready var blast_door_animator = self.get_tree().root.get_child(1).get_node("nuclear_door/AnimationPlayer");

func _ready() -> void:
	var mesh : MeshInstance3D = $MeshInstance3D;
	material  = mesh.material_override;


func open_the_blast_door():
	print('d')
	blast_door_animator.play("open")



func change_texture(tex : Texture):
	if material is StandardMaterial3D:
		material.albedo_texture = tex


func interact():
	if(machine_state == "off"):
		#change_texture(texture)
		$AnimationPlayer.play('turn_on')
		machine_state == "on"
		
	pass
