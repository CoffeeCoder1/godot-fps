extends Node3D

const LEVEL_3 = preload("res://scenes/levels/level_3/level_3.tscn")

var kill_count: int = 0


func _on_mob_spawner_all_killed() -> void:
	kill_count += 1
	
	if kill_count == 3:
		get_tree().change_scene_to_packed(LEVEL_3)
