extends Event

@export var i : int;


@export_category("event propreties")

@export var sprite : Sprite3D;
@export var audioplayer : AudioStreamPlayer3D;
var mat: ShaderMaterial
func _start():
	index = i;
	mat = sprite.material_override
	if mat == null:
		print("Material not set!")
	mat.set_shader_parameter("dissolve_amount", 1.0)
	




func interact():
	$AnimationPlayer.play("event")
	body_entered.disconnect(_on_body_entered)


func tween_play1():
	var tween = create_tween()
	tween.tween_property(
		mat,                           # object
		"shader_parameter/dissolve_amount",  # property path
		0.0,                           # القيمة النهائية
		3                            # المدة بالثواني
	)


func tween_play2():
	var tween2 = create_tween()
	tween2.tween_property(
		mat,
		"shader_parameter/burn_size",
		0.00,   # القيمة النهائية
		2.0    # المدة بالثواني
	)
	
