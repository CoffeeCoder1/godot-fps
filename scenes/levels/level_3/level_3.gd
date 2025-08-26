extends Node3D

var kill_count: int = 0


func _on_mob_spawner_all_killed() -> void:
	kill_count += 1
	
	if kill_count == 3:
		get_tree().quit()


func _on_lazer_crossed() -> void:
	get_tree().reload_current_scene()
