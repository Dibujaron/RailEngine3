extends Node2D

var a = null
var b = null

var center_local = null
var radius = 0

var angle_a_local = 0
var angle_b_local = 0

var center_to_a = null
var center_to_b = null
var ARC_COLOR = Color(0.5,0.5,0)
var SEG_LENGTH_MAX = 5

var ready = false

func _ready():
	a = get_node("PointA")
	b = get_node("PointB")
	calculate_curve()
	ready = true

func calculate_curve(): #work in only local coordinates.

	var a_pos = Vector2(0,0)
	var a_rot = 0
	var b_pos = b.position
	
	var a_hdg = Vector2(cos(a_rot), sin(a_rot)).normalized()
	var a_tan = a_hdg.tangent().normalized()
	var a_to_b = b_pos - a_pos
	var angle_1 = a_to_b.angle_to(a_tan)
	var angle_2 = PI - (angle_1 * 2)
	
	var a_dist_center = (sin(angle_1) * a_to_b.length()) / sin(angle_2)
	var to_center = a_tan * a_dist_center
	
	center_local = a_pos + to_center
	radius = abs(a_dist_center)
	
	center_to_a = a_pos - center_local
	center_to_b = b_pos - center_local
	angle_a_local = center_to_a.angle()
	angle_b_local = center_to_b.angle()

	a.position = Vector2(0,0)
	a.rotation = 0
	
	var sweep_angle = angle_b_local - angle_a_local
	b.rotation = a.rotation + sweep_angle

func _draw():
	if ready:
		draw_circle(center_local, 2, Color(1,0,0))
		draw_line(center_local, center_local+center_to_a, Color(0,1,1)) #green/blue should go to A
		draw_line(center_local, center_local+center_to_b, Color(1,1,0)) #yellow should go to B
		draw_arc()
	
func draw_arc():
	var start_angle = angle_a_local
	var end_angle = angle_b_local
	
	if start_angle > end_angle:
		var temp = end_angle
		end_angle = start_angle
		start_angle = temp
	var angle_sweep = end_angle - start_angle
	if angle_sweep < 0:
		print("ERR angle_sweep is ", angle_sweep, " must always be positive!")
		return
	var arc_length = radius * angle_sweep
	var n_segments = ceil(arc_length / SEG_LENGTH_MAX)
	var increment = angle_sweep / n_segments
	if increment < 0:
		print("ERR increment is ", increment, " must always be positive!")
		return

	var angle = start_angle
	while angle+increment < end_angle:
		var angle_next = angle+increment
		var p1 = center_local + Vector2(cos(angle),sin(angle)) * radius
		var p2 = center_local + Vector2(cos(angle_next),sin(angle_next)) * radius
		draw_line(p1, p2, ARC_COLOR)
		angle = angle_next

	#draw one more line, possibly not the same length as the rest, to complete it.
	var penultimate = center_local + Vector2(cos(angle),sin(angle)) * radius
	var end_point = center_local + Vector2(cos(end_angle),sin(end_angle)) * radius
	draw_line(penultimate, end_point, ARC_COLOR)

func invert():
	var b_pos = b.position
	var b_hdg = b.rotation
	b.position = a.position
	b.rotation = a.rotation
	a.position = b_pos
	a.rotation = b_hdg
	a.update()
	b.update()
	calculate_curve() #recalculate this new reversed curve.
	
	
