extends RigidBody3D

@export var health: int = 100


func take_damage(damage: int) -> void:
	health -= damage
	
	if health < 1:
		dead()


func dead() -> void:
	queue_free()
