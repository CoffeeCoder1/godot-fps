class_name EvilAI extends CharacterBody3D

@export var target: Node3D

var speed: float = 0.8
var acceleration: float = 10

@onready var agent: NavigationAgent3D = $NavigationAgent3D


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		agent.target_position = target.global_position
		var direction: Vector3 = (agent.get_next_path_position() - global_position)
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP, true)
	
	move_and_slide()
