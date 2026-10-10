extends Node2D

@onready var themed_timer: Node2D = $Themed_timer
@onready var orbs = [$Orb1, $Orb2]

var orb_collected = 0
var time_left := 7.5
var changing_scene = false

func _ready() -> void:
	_create_screen_walls()
	for orb in orbs:
		orb.garlic_collected.connect(garlic_collect)

func _create_screen_walls() -> void:
	var size := get_viewport_rect().size
	var t := 50.0
	_make_wall(Rect2(-t, 0, t, size.y))
	_make_wall(Rect2(size.x, 0, t, size.y))
	_make_wall(Rect2(0, -t, size.x, t))

func _make_wall(rect: Rect2) -> void:
	var body := StaticBody2D.new()
	var shape := CollisionShape2D.new()
	var rect_shape := RectangleShape2D.new()
	rect_shape.size = rect.size
	shape.shape = rect_shape
	body.position = rect.position + rect.size / 2
	body.add_child(shape)
	add_child(body)

func _process(delta: float) -> void:
	if changing_scene:
		return

	time_left -= delta
	themed_timer.time = max(time_left, 0.0) # le Themed_timer affiche cette valeur

	if orb_collected >= orbs.size():
		_go_to_level(true)
	elif time_left <= 0.0:
		_go_to_level(false)

func _go_to_level(won: bool) -> void:
	changing_scene = true
	if not won:
		Global.minigames_done -= 1 # le niveau le réincrémente : on rejoue ce minijeu
		Global.lives -= 1
	get_tree().change_scene_to_file("res://Scenes/Level_scene.tscn")

func garlic_collect() -> void:
	orb_collected += 1
