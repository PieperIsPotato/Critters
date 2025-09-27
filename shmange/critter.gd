extends RigidBody3D

@export var body_color : Color

func _ready() -> void:
	$MeshInstance3D.get_surface_override_material(0).albedo_color = body_color
	$"Teeth/MeatEat Teeth".get_surface_override_material(0).albedo_color = body_color
	$"Teeth/FruitEat Teeth".get_surface_override_material(0).albedo_color = body_color

func _physics_process(delta: float) -> void:
	rotation.x = rotation.x / 1.5
	rotation.z = rotation.z / 1.1
	
	var dir = transform.basis.z * 10
	apply_force(dir)
	
	if position.x > 63:
		position.x = -63
		position.y = 6
	if position.x < -63:
		position.x = 63
		position.y = 6
	if position.z > 63:
		position.z = -63
		position.y = 6
	if position.z < -63:
		position.z = 63
		position.y = 6

func _on_left_eye_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

func _on_left_eye_body_exited(body: Node3D) -> void:
	pass # Replace with function body.

func _on_right_eye_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

func _on_right_eye_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
