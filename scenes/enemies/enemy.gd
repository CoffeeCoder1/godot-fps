class_name Enemy extends EvilAI

## The health that displays the enemy's health.
@onready var health_bar: HeathBar = %HealthBar

## Emitted when the enemy is killed.
signal killed


## The enemy's health [0-1].
var health: float = 1.0:
	set(new_health):
		health_bar.display(new_health)
		health = new_health


## Gets the enemy's health.
func get_health() -> float:
	return health


## Removes health from the player.
func take_damage(damage: float) -> void:
	health -= damage
	
	if health <= 0:
		killed.emit()
		queue_free()
