extends State

var enemy: CharacterBody2D
var player: CharacterBody2D

var size = 128
var new_position: Array = []

class Point:
	var point: Vector2
	var close_point: Array
	var check_points: Array
	var g: int = 0
	var h: int = 0
	var connection: Point = null
	
	func _init(x, y):
		point = Vector2(x, y)
		close_point = [point + Vector2.UP * 128, point + Vector2.DOWN * 128, point + Vector2.RIGHT * 128, point + Vector2.LEFT * 128]
		check_points = [Vector2.UP * 128, Vector2.DOWN * 128, Vector2.RIGHT * 128, Vector2.LEFT * 128]
	
	func f():
		return (g * h)

var start_point = Vector2.ZERO
var target_point = Vector2.ZERO

func get_h(point: Vector2) -> int:
	return abs(point.x - target_point.point.x) + abs(point.y - target_point.point.y)
	
func find_point(point_array: Array, point: Point) -> int:
	for i in range(point_array.size()):
		if (point_array[i].point == point.point):
			return i
	return -1

func a_star() -> Array:
	var open_array = [start_point]
	var close_array = []
	
	while open_array.size() > 0:
		var current_point: Point = open_array[0]
		for i in range(open_array.size()):
			if (current_point.f() > open_array[i].f() || (current_point.f() == open_array[i].f() && current_point.h > open_array[i].h)):
				current_point = open_array[i]
		
		close_array.push_back(current_point)
		open_array.erase(current_point)
		if current_point.point.x == target_point.point.x && current_point.point.y == target_point.point.y:
			var current_point_path: Point = current_point
			var path = []
			while current_point_path.point.x != start_point.point.x || current_point_path.point.y != start_point.point.y:
				path.push_back(current_point_path)
				current_point_path = current_point_path.connection
			return path
			
		for i in range(current_point.close_point.size()):
			var close_point: Point = Point.new(current_point.close_point[i].x, current_point.close_point[i].y)
			if find_point(close_array, close_point) != -1 || enemy.test_move(Transform2D(Vector2(1,0), Vector2(0,1), current_point.point), current_point.check_points[i]):
				if current_point.point + current_point.check_points[i] == target_point.point:
					return []
				continue
			var cost_next: int = current_point.g + 1
			
			if find_point(open_array, close_point) == -1 || cost_next < open_array[find_point(open_array, close_point)].g:
				close_point.g = cost_next
				close_point.connection = current_point
				close_point.h = get_h(close_point.point)
				open_array.push_back(close_point)
					
	return []


func Move():
	start_point = Point.new(enemy.position.x, enemy.position.y)
	target_point = Point.new(player.position.x, player.position.y)
	if new_position.size() == 0 || (new_position.size() > 0 && new_position[new_position.size() - 1].point != player.position): 
		new_position = a_star()
		new_position.reverse()
	if (new_position.size() > 0):
		enemy.position = new_position.pop_front().point

func Enter():
	start_point = Point.new(enemy.position.x, enemy.position.y)
	target_point = Point.new(player.position.x, player.position.y)
	player.connect("end_turn", Move)

func Exit():
	player.disconnect("end_turn", Move)
