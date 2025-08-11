extends StaticBody3D

@export var object_name : String;


@export var pickup_item : bool =false; # necessery

var machine_state = "off";

var material : StandardMaterial3D;

@export var texture : Texture;
@export var pc_ui : Control;
@export var blast_door : Node3D;

var first_time = true;
func _ready() -> void:
	var mesh : MeshInstance3D = $MeshInstance3D;
	material  = mesh.material_override;


func open_the_blast_door():
	blast_door.get_node("AnimationPlayer").play("open")



func change_texture(tex : Texture):
	if material is StandardMaterial3D:
		material.albedo_texture = tex


func interact():
	if(first_time == true):
		pc_ui.visible = true;
		pc_ui.get_node("codeInput").text = ""
		Global.toggle_mouse();
	pass

func first_animation():
	if(machine_state == "off"):
		#change_texture(texture)
		$AnimationPlayer.play('turn_on')
		machine_state == "on"
		
