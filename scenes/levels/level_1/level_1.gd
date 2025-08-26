extends Node3D

const LEVEL_2 = preload("res://scenes/levels/level_2/level_2.tscn")


func _on_mob_spawner_all_killed() -> void:
	get_tree().change_scene_to_packed(LEVEL_2)
