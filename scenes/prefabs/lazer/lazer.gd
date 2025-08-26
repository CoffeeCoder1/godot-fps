class_name Lazer extends RayCast3D

## The rate at which the beam color cycles.
@export var color_cycle_rate: float = 0.25

## Emitted when a player crosses the beam.
signal crossed

@onready var beam: MeshInstance3D = %Beam


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	force_raycast_update()
	
	if is_colliding():
		var starting_point: Vector3 = to_local(get_collision_point())
		
		beam.mesh.height = starting_point.y
		beam.position.y = starting_point.y * 0.5
		
	if get_collider() is Player:
		var material := beam.get_surface_override_material(0) as StandardMaterial3D
		material.albedo_color = Color.RED
		material.emission = Color.RED
		beam.set_surface_override_material(0, material)
		crossed.emit()
	else:
		var material := beam.get_surface_override_material(0) as StandardMaterial3D
		material.albedo_color.h += color_cycle_rate * delta
		material.emission.h += color_cycle_rate * delta
		beam.set_surface_override_material(0, material)
