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
var SEG_LENGTH = 5

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
	radius = a_dist_center
	
	center_to_a = a_pos - center_local
	center_to_b = b_pos - center_local
	print("Center to b is ", center_to_b.normalized(), " with angle ", center_to_b.normalized().angle())
	angle_a_local = center_to_a.angle()
	angle_b_local = center_to_b.angle()
	
	print("B's rotation angle being set to a heading of ", center_to_b.tangent().normalized())
	b.rotation = center_to_b.tangent().angle()
	a.position = Vector2(0,0)
	a.rotation = 0
	
	a.update()
	b.update()
	update()

func _draw():
	if ready:
		draw_circle(center_local, 2, Color(1,0,0))
		draw_line(center_local, center_local+center_to_a, Color(0,0,1))
		draw_line(center_local, center_local+center_to_b, Color(0,0,1))
		draw_circle_arc(center_local, radius, angle_a_local, angle_b_local, ARC_COLOR)
			
func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points+1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
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
	
	
