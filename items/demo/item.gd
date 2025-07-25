extends StaticBody3D

@export var my_doors : Array[StaticBody3D];

func interact():
	if(my_doors != []):
		for door in my_doors:
			door.islocked = false
			print(door)

	pass
