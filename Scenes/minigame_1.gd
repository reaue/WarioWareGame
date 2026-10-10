extends Node2D

@onready var themed_timer: Node2D = $Themed_timer
@onready var orbs = [$Orb1, $Orb2]

var garlic_collected = 0
var timer_end = false
var changing_scene = false

func _ready() -> void:
	for orb in orbs:
		orb.garlic_collected.connect(garlic_collect)
	await themed_timer.Timer(10.0)
	timer_end = true

func _process(delta: float) -> void:
	if changing_scene:
		return

	if garlic_collected == 3:
		changing_scene = true
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Themed_timer.tscn")
		return

	if timer_end:
		changing_scene = true
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/Themed_timer.tscn")

func garlic_collect() -> void:
	garlic_collected += 1
