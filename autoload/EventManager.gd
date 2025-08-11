extends Node

var current_event_index: int = 0 
var events_done: Array = []      

func start_event(index: int) -> bool:
	if index == current_event_index:
		print("start_event", index)
		return true
	return false

func complete_event(index: int):
	if index == current_event_index:
		events_done.append(index)
		current_event_index += 1
		print("the current event index : ",current_event_index)
