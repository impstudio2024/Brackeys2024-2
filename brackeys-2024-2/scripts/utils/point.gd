
class_name Point

var point: Vector2
var close_point: Array
var check_points: Array
var g: int = 0
var h: int = 0
var connection: Point = null

func _init(x, y, size):
	point = Vector2(x, y)
	close_point = [point + Vector2.UP * size, point + Vector2.DOWN * size, point + Vector2.RIGHT * size, point + Vector2.LEFT * size]
	check_points = [Vector2.UP * size, Vector2.DOWN * size, Vector2.RIGHT * size, Vector2.LEFT * size]

func f():
	return (g * h)
