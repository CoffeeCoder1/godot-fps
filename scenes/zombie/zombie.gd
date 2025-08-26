class_name Zombie extends Enemy

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _process(delta: float) -> void:
	if velocity.length() > 0:
		animation_player.play("walk")
