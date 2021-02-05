extends KinematicBody2D
class_name player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parent
var target
var id = 0
onready var ray = $RayCast2D
onready var ray2= $RayCast2D2
onready var ray3= $RayCast2D3
onready var ray4= $RayCast2D4

#Save
var weightx = 0
var weighty = 0
var weight2x = 0
var weight2y = 0
var weight3x = 0
var weight3y = 0
var weight4x = 0
var weight4y = 0
var weight5 = 0
var weights = [weightx, weighty, weight2x, weight2y]
#/Save
func _ready():
	pass # Replace with function body.
func start():
	$Timer.start()
var maxRand = .01
func randomizeWeights():
	randomize()
	weightx += rand_range(-maxRand,maxRand)
	weighty += rand_range(-maxRand,maxRand)
	randomize()
	weight2x += rand_range(-maxRand,maxRand)
	weight2y += rand_range(-maxRand,maxRand)
	randomize()
	weight3x += rand_range(-maxRand,maxRand)
	weight3y += rand_range(-maxRand,maxRand)
	randomize()
	weight4x += rand_range(-maxRand,maxRand)
	weight4y += rand_range(-maxRand,maxRand)
	randomize()
	weight5 += rand_range(-maxRand,maxRand)
	#Limit
	weightx = min(weightx, 1.0)
	weighty = min(weighty, 1.0)
	weight2x = min(weight2x, 1.0)
	weight2y = min(weight2y, 1.0)
	weight3x = min(weight3x, 1.0)
	weight3y = min(weight3y, 1.0)
	weight4x = min(weight4x, 1.0)
	weight4y = min(weight4y, 1.0)
	weight5 = min(weight5, 1.0)
	
	weightx = max(weightx, -1.0)
	weighty = max(weighty, -1.0)
	weight2x = max(weight2x, -1.0)
	weight2y = max(weight2y, -1.0)
	weight3x = max(weight3x, -1.0)
	weight3y = max(weight3y, -1.0)
	weight4x = max(weight4x, -1.0)
	weight4y = max(weight4y, -1.0)
	weight5 = max(weight5, -1.0)
func die():
	get_parent().remove_child(self)
	queue_free()
var speed = .005
var frames = 0
func _process(delta): #_physics
	ray.force_raycast_update()
	ray2.force_raycast_update()
	ray3.force_raycast_update()
	ray4.force_raycast_update()
	var distance = ray.get_collision_point().distance_to(global_position)
	var distance2 = ray2.get_collision_point().distance_to(global_position)
	var distance3 = ray3.get_collision_point().distance_to(global_position)
	var distance4 = ray4.get_collision_point().distance_to(global_position)
	var x = 1
	var y = 1
#	randomize()
#	var luck1 = randi()
#	if luck1 % 2 == 0:
#		x = -1
#	randomize()
#	var luck2 = randi()
#	if luck2 % 2 == 0:
#		y = -1
	var dist = Vector2(1, 1)
	if is_instance_valid(target):
		dist = Vector2(
			abs(global_position.x - target.global_position.x),
			abs(global_position.y - target.global_position.y)
		)
	global_position.y += (y*speed)*(distance*weightx)*(distance2*weight2x)*(distance3*weight3x)*(distance4*weight4x)*(dist.x*weight5)
	global_position.x += (x*speed)*(distance*weighty)*(distance2*weight2y)*(distance3*weight3y)*(distance4*weight4x)*(dist.y*weight5)
	if global_position.x > 1200 or global_position.x < 0 or global_position.y > 700 or global_position.y < 0:
		if is_instance_valid(parent):
			parent.kill(self)
	frames += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if is_instance_valid(parent):
		parent.kill(self)
