extends Control



var item_name = "" ;


func _process(delta: float) -> void:
	item_name =  self.get_node("item_name").text
	
	
	
func _on_button_pressed() -> void:
	print(item_name)
