extends Area2D

signal garlic_collected

@onready var player: CharacterBody2D = $"../Player"
@onready var sprite: Sprite2D = $Sprite2D

var time := 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	time += delta
	sprite.position.y = sin(time * 4.0) * 8.0

func _on_body_entered(body: Node2D) -> void:
	if body == player and visible:
		garlic_collected.emit()
		set_deferred("monitoring", false)
		hide()
		
