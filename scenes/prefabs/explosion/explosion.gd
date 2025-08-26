class_name Explosion extends Node3D

signal finished

@onready var debris: GPUParticles3D = $Debris
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke


## Triggers the explosion
func explode() -> void:
	debris.emitting = true
	fire.emitting = true
	smoke.emitting = true


func _on_smoke_finished() -> void:
	finished.emit()
