extends ITEM



@export var paper_name : String

@onready var paper_ui : Control = self.get_tree().root.get_child(1).get_node("read")



func interact():
	$AudioStreamPlayer3D.play()
	paper_ui.get_node("text").text = ""
	paper_ui.get_node("text").text = Global.show_paper(paper_name)
	paper_ui.visible = !paper_ui.visible
	Global.toggle_mouse();
