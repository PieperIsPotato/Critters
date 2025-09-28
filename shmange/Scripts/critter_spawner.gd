extends Sprite3D

@export var camera : Camera3D
@export var critter : PackedScene

func _process(delta: float) -> void:
	position.x = camera.position.x
	position.z = camera.position.z
	
	if camera.current:
		if Input.is_action_just_pressed("spawn"):
			var critter_inst = critter.instantiate()
			
			add_sibling(critter_inst)
			
			critter_inst.position = position - Vector3(0,1,0)
			
			critter_inst.set("body_color", CritterVariables.critterColor)
			critter_inst.set("teeth", CritterVariables.critterTeeth)
			
			critter_inst.setup()
