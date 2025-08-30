@tool
extends Node3D

func _ready():
	check_nodes(self)

func check_nodes(node: Node):
	for child in node.get_children():
		if child.get_script() != null:
			var script = child.get_script()
			if script is GDScript and script.base_class == "StaticBody3D" and not (child is StaticBody3D):
				var parent = child.get_parent()
				if parent:
					print("⚠️ Problem in parent:", parent.name, " (child:", child.name, ")")
		check_nodes(child)
