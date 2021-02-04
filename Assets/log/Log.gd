extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text1 = "ID 1001"
var text2 = "Score 1010"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func create():
	$Label.text = str(text1)
	$Label2.text = str(text2)
func setTimer(secs):
	$Death.start(secs)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Death_timeout():
	get_parent().remove_child(self)
	queue_free()
