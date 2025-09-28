extends StaticBody3D

@export var noisetexture : NoiseTexture2D
@export var amptexture : NoiseTexture2D

func _ready() -> void:
	noisetexture.noise.seed = randi_range(1,1000)
	amptexture.noise.seed = randi_range(1001,2000)
	var out : Array
	for x in 64:
		for y in 64:
			out.append(noisetexture.noise.get_noise_2d(x,y) * (amptexture.noise.get_noise_2d(x,y) + 1) * 35)
	$CollisionShape3D.shape.map_data = PackedFloat32Array(out)
	$MeshInstance3D.mesh.material.set("shader_parameter/noise", PackedFloat32Array(out))
