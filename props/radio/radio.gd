extends StaticBody3D



@export var object_name : String; # necessery
@export var pickup_item : bool =false; # necessery

@export var turn_off_sound_fx : AudioStream;

func interact():
	$AudioStreamPlayer3D.stream = turn_off_sound_fx;
	$AudioStreamPlayer3D.play();
	pass
