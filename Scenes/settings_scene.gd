extends Node2D

const CONFIG_PATH := "user://settings.cfg"

@onready var volume_slider: HSlider = get_node_or_null("VBoxContainer/VolumeSlider")

func _ready() -> void:
	if volume_slider == null:
		push_error("VolumeSlider introuvable. Enfants de la racine : " + str(get_children()))
		return
	var cfg := ConfigFile.new()
	cfg.load(CONFIG_PATH)
	volume_slider.value = cfg.get_value("audio", "volume", 0.8)
	volume_slider.value_changed.connect(_on_volume_changed)

func _on_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	var cfg := ConfigFile.new()
	cfg.load(CONFIG_PATH)
	cfg.set_value("audio", "volume", value)
	cfg.save(CONFIG_PATH)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Title_scene.tscn")
