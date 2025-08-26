class_name MobSpawner extends Node3D

## The scene to spawn for mobs.
@export var mob_prefab: PackedScene
## How long to wait between mob spawns.
@export var spawn_time: float = 5.0
## The node that children should navigate towards.
@export var navigation_target: Node3D
@export var mob_count: int = 15

@onready var spawn_point: Marker3D = $SpawnPoint
@onready var timer: Timer = $Timer

## Emitted when all the enemies are killed.
signal all_killed

var _counter: int = 0
var _kill_counter: int = 0


func _ready() -> void:
	timer.wait_time = spawn_time
	timer.start()


func _spawn() -> void:
	if _counter < mob_count:
		var mob := mob_prefab.instantiate() as Enemy
		mob.target = navigation_target
		mob.global_transform = spawn_point.global_transform
		get_parent().add_child(mob)
		
		mob.killed.connect(_mob_killed)
		
		_counter += 1


func _mob_killed() -> void:
	_kill_counter += 1
	
	if _kill_counter == mob_count:
		all_killed.emit()
