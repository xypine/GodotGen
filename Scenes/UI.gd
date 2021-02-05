extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var logContainer = $VBoxContainer/LogContainer/CentralLog
var logPre = preload("res://Assets/log/Log.tscn")
func addLog(text1, text2):
	var logp = logPre.instance()
	logp.text1 = text1
	logp.text2 = text2
	logp.create()
	logContainer.add_child(logp)
	logp.setTimer(2)
func clearLog():
	for i in logContainer.get_children():
		logContainer.remove_child(i)
