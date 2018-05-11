extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const POSITION_COLOR = Color(0,0,1)
const HEADING_COLOR = Color(1,0,0)
const TANGENT_COLOR = Color(0,1,0)

const DRAW_SCALE = 20

func _draw():

	var pos = Vector2(0,0)
	var heading = Vector2(0,1) * DRAW_SCALE

	draw_line(pos, pos+heading, HEADING_COLOR) #draw the heading in red
	var tangent = Vector2(1,0) * DRAW_SCALE

	draw_line(pos, pos+tangent, TANGENT_COLOR) #draw the tangent in green
	draw_circle(pos, 2, POSITION_COLOR) #draw the point first.
	print("my global rotation is ", global_rotation_degrees, " and my local rotation is ", rotation_degrees)

func heading():
	return Vector2(cos(rotation),sin(rotation))

func heading_global():
	return Vector2(cos(global_rotation),sin(global_rotation))
	
func tangent():
	return heading().tangent()

func tangent_global():
	return heading_global().tangent()