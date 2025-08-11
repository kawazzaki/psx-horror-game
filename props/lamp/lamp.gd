@tool
extends Node3D

@export var light_color: Color = Color(1, 1, 1):
	set(value):
		light_color = value
		if omni_light:
			omni_light.light_color = value

var omni_light: OmniLight3D

func _ready():
	# العثور على الضوء
	omni_light = $OmniLight3D
	# ضبط اللون عند بداية التشغيل (في المحرر أو اللعبة)
	if omni_light:
		omni_light.light_color = light_color
