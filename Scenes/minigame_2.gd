extends Node2D

@onready var themed_timer: Node2D = $Themed_timer

var buttons_pressed := 0
var time_left := 5.0
var changing_scene := false

func _process(delta: float) -> void:
	if changing_scene:
		return

	time_left -= delta
	themed_timer.time = max(time_left, 0.0)

	if buttons_pressed >= 5:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	elif time_left <= 0.0:
		_go_to_level(false)

func _go_to_level(won: bool) -> void:
	changing_scene = true
	Global.minigames_done -= 1
	Global.lives -= 1
	get_tree().change_scene_to_file("res://Scenes/Level_scene.tscn")

func on_button_pressed() -> void:
	buttons_pressed += 1
