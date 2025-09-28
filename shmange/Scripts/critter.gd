extends RigidBody3D

var body_color
var teeth

var previous_position = Vector3(0,0,0)

func _ready() -> void:
	var mat = StandardMaterial3D.new()
	$MeshInstance3D.set_surface_override_material(0, mat)
	$"Teeth/MeatEat Teeth".set_surface_override_material(0, mat)
	$"Teeth/FruitEat Teeth".set_surface_override_material(0, mat)
	apply_impulse(Vector3(0,-6,0))

func _process(delta: float) -> void:
	if name == "Model Critter":
		var colorpick = $"../../../TabContainer/Genetics/Color/ColorPicker"
		body_color = colorpick.color
		CritterVariables.critterColor = body_color
		
		var teethpick = $"../../../TabContainer/body/Teeth/TabBar"
		teeth = teethpick.current_tab
		CritterVariables.critterTeeth = teeth
		
		setup()

func _physics_process(delta: float) -> void:
	rotation.x = rotation.x / 1.5
	rotation.z = rotation.z / 1.1
	
	var dir = transform.basis.z * 10
	apply_force(dir)
	
	if linear_velocity.y > 0:
		if linear_velocity.x > -0.3 && linear_velocity.x < 0.3:
			if linear_velocity.z > -0.3 && linear_velocity.z < 0.3:
				apply_impulse(Vector3(0,4,0))

func setup():
	$MeshInstance3D.get_surface_override_material(0).albedo_color = body_color
	
	$"Teeth/FruitEat Teeth".visible = false
	$"Teeth/MeatEat Teeth".visible = false
	if teeth == 0:
		$"Teeth/FruitEat Teeth".visible = true
	if teeth == 1:
		$"Teeth/MeatEat Teeth".visible = true

func _on_left_eye_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

func _on_left_eye_body_exited(body: Node3D) -> void:
	pass # Replace with function body.

func _on_right_eye_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

func _on_right_eye_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
