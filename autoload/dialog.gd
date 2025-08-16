extends Node



#
@onready var dialog_ui := self.get_tree().root.get_child( self.get_tree().root.get_child_count() - 1).get_node("dialog_system")
