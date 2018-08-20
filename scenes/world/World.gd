extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	
	var curve1 = get_node("Curve1")
	var curve2 = get_node("Curve2")
	var curve3 = get_node("Curve3")
	var curve4 = get_node("Curve4")
	var straight1 = get_node("Straight1")
	curve1.global_position = Vector2(100,200)
	curve1.global_rotation = 0
	get_node("Curve1/PointB").position = Vector2(50, 25)
	curve1.calculate_curve()
	
	curve2.global_position = Vector2(300,200)
	curve2.global_rotation = 0
	get_node("Curve2/PointB").position = Vector2(50, -25)
	curve2.calculate_curve()
	
	curve3.global_position = Vector2(500,200)
	curve3.global_rotation = 0
	get_node("Curve3/PointB").position = Vector2(-50, 25)
	curve3.calculate_curve()
	
	curve4.global_position = Vector2(700,200)
	curve4.global_rotation = 0
	get_node("Curve4/PointB").position = Vector2(-50, -25)
	curve4.calculate_curve()
	
	straight1.global_position = Vector2(800,200)
	straight1.global_rotation = 25
	get_node("Straight1/PointB").position = Vector2(-50, 25)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
