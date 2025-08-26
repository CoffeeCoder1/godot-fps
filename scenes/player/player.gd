class_name Player extends CharacterBody3D

const GRENADE = preload("res://scenes/prefabs/grenade/grenade.tscn")

## The speed at which the player walks.
@export var speed: float = 5.0
## The velocity impulse applied when jumping.
@export var jump_velocity: float = 10.0
## The impulse applied when throwing objects.
@export var throw_force: float = 5.0
## The mouse sensitivity when turning.
@export var mouse_sensitivity: float = 0.2
## The maximum head yaw value.
@export var yaw_min: float
## The minimum head yaw value.
@export var yaw_max: float

var yaw: float = 0.0
var pitch: float = 0.0

@onready var head: Node3D = %Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var hand: Marker3D = $Hand


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		
		pitch = clamp(pitch, -90, 90)
		
		rotation_degrees.y = yaw
		head.rotation_degrees.x = pitch
	
	if event.is_action_pressed("fire"):
		var grenade: Grenade = GRENADE.instantiate()
		
		get_parent().add_child(grenade)
		
		grenade.global_position = hand.global_position + (head.global_transform.basis.z * -1)
		
		# Apply throwing force
		var direction: Vector3 = grenade.global_transform.origin - hand.global_transform.origin
		if direction.length() > 0:
			direction = direction.normalized()
			grenade.apply_central_impulse(direction * throw_force)
