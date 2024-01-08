extends RigidBody3D

## How much vertical force to apply when moving
@export_range(750.0,3000.0) var thrust: float = 1000.0

## How much torque to apply when moving
@export var torque_thrust: float = 100.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0,0.0,torque_thrust) * delta)
	
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0,0.0,-torque_thrust) * delta)
		


func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		complete_level(body.file_path)
		
	if "Hazard" in body.get_groups():
		crashSecuence()
		
		
func crashSecuence() -> void:
	print("BOOM")
	get_tree().reload_current_scene()
	
func complete_level(next_level_file: String) -> void:
	print("Level Complete")
	get_tree().change_scene_to_file(next_level_file)
