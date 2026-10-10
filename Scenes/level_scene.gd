extends Node2D

@onready var hearts: Array[TextureRect] = [
	$HeartContainer/TextureRect,
	$HeartContainer/TextureRect2,
	$HeartContainer/TextureRect3,
]

@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time

func _ready() -> void:
	await Timer(2.5)

	if Global.minigames_done < 2:
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://Scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")

func _process(delta: float) -> void:
	if 0 == Global.lives:
		get_tree().change_scene_to_file("res://Scenes/death.screen.tscn")
	for i in hearts.size():
		hearts[i].visible = i < Global.lives # le cœur i est visible si on a au moins i+1 vies

	timer.text = str(snapped(time, 0.1))
	level.text = "Level " + str(Global.minigames_done)

func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time -= 0.1

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
