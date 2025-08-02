extends ColorRect



func change_chromaticAberrationOffset(value : float):
	self.material.set("shader_parameter/chromaticAberrationOffset",value)
	pass


func change_brightnessMult(value : float):
	self.material.set("shader_parameter/brightnessMult",value)
	pass
