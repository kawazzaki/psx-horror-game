extends StaticBody3D

@export var pickup_item : bool =false; # necessery

var machine_state = "off";

var material : StandardMaterial3D;

@export var texture : Texture;

func _ready() -> void:
	var mesh : MeshInstance3D = $MeshInstance3D;
	material  = mesh.material_override;




func change_texture(tex : Texture):
	if material is StandardMaterial3D:
		material.albedo_texture = tex


func interact():
	if(machine_state == "off"):
		#change_texture(texture)
		$AnimationPlayer.play('turn_on')
		machine_state == "on"
		
	pass
