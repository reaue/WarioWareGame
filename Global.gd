extends Node

var minigames_done = 0
var lives = 3

var music := AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music)
	music.stream = load("res://paulyudin-game-game-music-573991.mp3") # adapte le nom si tu as mis un .mp3
	music.play()

	var cfg := ConfigFile.new()
	if cfg.load("user://settings.cfg") == OK:
		AudioServer.set_bus_volume_db(0, linear_to_db(cfg.get_value("audio", "volume", 0.8)))
