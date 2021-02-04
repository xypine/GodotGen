extends KinematicBody2D
class_name player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parent
onready var ray = $RayCast2D

#Save
var weightx = 1.0
var weighty = 1.0
#/Save
func _ready():
	pass # Replace with function body.
func start():
	randomize()
	weightx = rand_range(0.0, 1.0)
	weighty = rand_range(0.0, 1.0)
	$Timer.start()
func die():
	get_parent().remove_child(self)
	queue_free()
var speed = .1
func _physics_process(delta):
	ray.force_raycast_update()
	var distance = ray.get_collision_point().distance_to(global_position)
	var x = .5
	var y = .5
#	randomize()
#	var luck1 = randi()
#	if luck1 % 2 == 0:
#		x = -1
#	randomize()
#	var luck2 = randi()
#	if luck2 % 2 == 0:
#		y = -1
	global_position.y += (y*speed)*(distance*weightx)
	global_position.x += (x*speed)*(distance*weighty)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if is_instance_valid(parent):
		parent.kill(self)
