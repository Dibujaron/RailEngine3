extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const POSITION_COLOR = Color(0,0,1)
const HEADING_COLOR = Color(1,0,0)
const TANGENT_COLOR = Color(0,1,0)

const DRAW_SCALE = 20

func _draw():
	print("Drawing!")
	var pos = Vector2(0,0)
	var heading = heading().normalized() * DRAW_SCALE
	print("Heading is ", heading().normalized())
	print("Drawing heading line from ", position, " to ", (position+heading))
	draw_line(pos, pos+heading, HEADING_COLOR) #draw the heading
	var tangent = heading.tangent().normalized() * DRAW_SCALE
	print("Drawing tangent line ", heading.tangent().normalized() , " with angle ", heading.tangent().normalized().angle())
	draw_line(pos, pos+tangent, TANGENT_COLOR) #draw the tangent
	draw_circle(pos, 2, POSITION_COLOR) #draw the point first.

func heading():
	return Vector2(cos(rotation),sin(rotation))

func heading_global():
	return Vector2(cos(global_rotation),sin(global_rotation))
	
func tangent():
	return heading().tangent()

func tangent_global():
	return heading_global().tangent()