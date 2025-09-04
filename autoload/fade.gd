extends CanvasLayer

@onready var rect := ColorRect.new()
var tween: Tween

func _ready():
	# إعداد ColorRect أسود يغطي الشاشة
	rect.color = Color.BLACK
	rect.size = get_viewport().get_visible_rect().size
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	rect.modulate.a = 1.0  
	rect.mouse_filter =Control.MOUSE_FILTER_IGNORE
	add_child(rect)

func fade_in(duration: float = 1.0):
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, duration)

func fade_out(duration: float = 1.0):
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, duration)
