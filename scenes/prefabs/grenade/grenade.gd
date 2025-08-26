class_name Grenade extends RigidBody3D

## The time to wait before exploding.
@export var delay_time: float = 1
## The size of the zone within which objects will be affected.
@export var explosion_zone: float = 10.0
## The damage which the explosion deals.
@export var explosion_damage: float = 0.5
## The force with which the explosion pushes on bodies within the zone.
@export var explosion_force: float = 10.0

@onready var timer: Timer = $Timer
@onready var area_of_explosion: Area3D = $AreaOfExplosion
@onready var area_of_explosion_collider: CollisionShape3D = $AreaOfExplosion/CollisionShape3D
@onready var explosion: Explosion = $Explosion
@onready var model: Node3D = $Model


func _ready() -> void:
	timer.wait_time = delay_time
	timer.start()
	area_of_explosion.scale = Vector3.ONE * explosion_zone
	
	if area_of_explosion_collider.shape is SphereShape3D:
		area_of_explosion_collider.shape.radius = explosion_zone


func _on_timer_timeout() -> void:
	explode()


## Triggers the explosion animation.
func explode() -> void:
	var bodies = area_of_explosion.get_overlapping_bodies()
	for body in bodies:
		# Apply an impulse to RigidBodies
		if body is RigidBody3D:
			var direction: Vector3 = body.global_transform.origin - global_transform.origin
			if direction.length() > 0:
				direction = direction.normalized()
				body.apply_central_impulse(direction * explosion_force)
		
		# Damage damagable objects
		if body.has_method("take_damage"):
			body.call("take_damage", explosion_damage)
	
	# Hide the model when it explodes
	model.hide()
	
	explosion.explode()


func _on_explosion_finished() -> void:
	# Free this object once the explosion animation is done
	queue_free()
