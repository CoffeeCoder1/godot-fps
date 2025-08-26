class_name HeathBar extends Control

@onready var progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	progress_bar.value = 100


## Displays the given percentage [0-1].
func display(percentage: float) -> void:
	percentage = clampf(percentage, 0, 1)
	
	progress_bar.value = percentage
