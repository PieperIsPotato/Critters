extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		rotation.y -= 1 * delta
	if Input.is_action_pressed("right"):
		rotation.y += 1 * delta
	if Input.is_action_pressed("down"):
		rotation.x += 1 * delta
	if Input.is_action_pressed("up"):
		rotation.x -= 1 * delta
	
	if Input.is_action_pressed("zoomin"):
		$Camera3D.position.z -= 0.05
	if Input.is_action_pressed("zoomout"):
		$Camera3D.position.z += 0.05
	
	rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	$Camera3D.position.z = clamp($Camera3D.position.z, 1.5, 8)
