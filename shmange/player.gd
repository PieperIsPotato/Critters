extends CharacterBody3D

@export var camera : Camera3D
@export var camera2 : Camera3D

var main

const SPEED = 4.0
const JUMP = 6.0
const GRAVITY = Vector3(0,-9.8,0)
const SENSITIVITY = 0.003

var wet = false
var captured = false

func _unhandled_input(event):
	if captured and camera.current:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _process(delta: float) -> void:
	main = get_tree().get_root().get_child(0).find_child("TabContainer").find_child("Main")
	
	if !camera.current:
		wet = false
	main.get_child(0).material.set("shader_parameter/wet",wet)
	$"../Water/MeshInstance3D".visible = !wet
	$"../Water/BackFace".visible = wet
	
	if main.find_child("ViewCheck").value:
		camera2.current = false
		camera.current = true
	else:
		camera2.current = true
		camera.current = false

func _physics_process(delta: float) -> void:
	var speed_mod = 1
	if Input.is_action_pressed("sprint"):
		speed_mod *= 4
	
	if not is_on_floor():
		if wet:
			velocity += GRAVITY * speed_mod * delta * Vector3(0,-0.3,0)
		else:
			velocity += GRAVITY * speed_mod * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP * speed_mod
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction : Vector3 = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED * speed_mod
			velocity.z = direction.z * SPEED * speed_mod
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED * speed_mod, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * SPEED * speed_mod, delta * 2.0)	
	
	if main:
		if main.visible:
			if camera.current:
				move_and_slide()
			else:
				camera2.position += Vector3(input_dir.x,0,input_dir.y) * camera2.position.y / 64
				if Input.is_action_pressed("zoomin"):
					camera2.position.y -= 1
				if Input.is_action_pressed("zoomout"):
					camera2.position.y += 1
				camera2.position.y = clamp(camera2.position.y,10,128)
	
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
	
	if camera2.position.x > 63:
		camera2.position.x = -63
	if camera2.position.x < -63:
		camera2.position.x = 63
	if camera2.position.z > 63:
		camera2.position.z = -63
	if camera2.position.z < -63:
		camera2.position.z = 63

func _input(event):
	if Input.is_action_just_pressed("fullsc"):
		if camera.current:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			captured = true
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		captured = false

func _on_water_body_entered(body: Node3D) -> void:
	if body == self:
		wet = true

func _on_water_body_exited(body: Node3D) -> void:
	if body == self:
		wet = false
