extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerPrefab = preload("res://Assets/ai/player.tscn")
onready var spawnPoint = $Points/Startpos
onready var goal = $Points/Goal
onready var bestpos = $Points/BestPos
onready var container = $Players
onready var UI = $UI

var active = []
var active_max = 0

func spawn():
	var p = playerPrefab.instance()
	p.parent = self
	p.global_position = spawnPoint.global_position
	container.add_child(p)
	active.append(p)
	p.start()
	return p
var best_score = -1
func kill(p):
	var score = score(p)
	if score > best_score:
		best_score = score
		bestpos.global_position = p.global_position
	UI.addLog("0", score)
	p.die()
	active.remove(active.find(p))
func score(p):
	var pl = p.global_position
	var d = goalPoint.distance_to(pl)
	return 1000 - d
# Called when the node enters the scene tree for the first time.
func _ready():
	active_max = 1
	spawn()


onready var ui_left = $UI/VBoxContainer/StatsContainer/Left
onready var ui_fps  = $UI/VBoxContainer/StatsContainer/FPS
func updateUI():
	ui_fps.text = str(Engine.get_frames_per_second())
	ui_left.text = str(len(active)) + "/" + str(active_max) + " left"
# Called every frame. 'delta' is the elapsed time since the previous frame.
var goalPoint = Vector2(0, 0)
func _process(delta):
	goalPoint = goal.global_position
	updateUI()


func _on_Diezone_body_entered(body):
	if body is player:
		kill(body)


func _on_SpawnTimer_timeout():
	spawn()
