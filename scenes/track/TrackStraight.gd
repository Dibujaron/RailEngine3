extends Node2D

var a = null
var b = null
var LINE_COLOR = Color(0.5,0.5,0)
var ready = false

func _ready():
	a = get_node("PointA")
	b = get_node("PointB")
	if b.rotation != a.rotation:
		print("ERR straight line does not have equal headings for both points!")
	ready = true
func _draw():
	if ready:
		draw_line(a.position, b.position, LINE_COLOR) #green/blue should go to A

func invert():
	var b_pos = b.position
	var b_hdg = b.rotation
	b.position = a.position
	b.rotation = a.rotation
	a.position = b_pos
	a.rotation = b_hdg
	a.update()
	b.update()
	
	
