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

var idSpace = 0
var gen = 0
func spawn():
	var p = playerPrefab.instance()
	p.id = idSpace
	p.parent = self
	p.target = goal
	p.global_position = spawnPoint.global_position
	container.add_child(p)
	active.append(p)
	p.start()
	idSpace += 1
	return p
var best_score = -1
var wx = 0
var wy = 0
var w2x = 0
var w2y = 0
var w3x = 0
var w3y = 0
var w4x = 0
var w4y = 0
var w5 = 0
var x = []
var y = []
var x2= []
var y2= []
var x3= []
var y3= []
var x4= []
var y4= []
var v5= []
var scores = {}
var i2 = 0
func kill(p):
	var score = score(p)
	if score > best_score:
		best_score = score
		bestpos.global_position = p.global_position
		wx = p.weightx
		wy = p.weighty
		w2x = p.weight2x
		w2y = p.weight2y
		w3x = p.weight3x
		w3y = p.weight3y
		w4x = p.weight4x
		w4y = p.weight4y
		w5 = p.weight5
	x.append(p.weightx)
	y.append(p.weighty)
	x2.append(p.weight2x)
	y2.append(p.weight2y)
	x3.append(p.weight3x)
	y3.append(p.weight3y)
	x4.append(p.weight4x)
	y4.append(p.weight4y)
	v5.append(p.weight5)
	scores[i2] = score
	i2 += 1
	UI.addLog(p.id, score)
	p.die()
	active.remove(active.find(p))
func score(p):
	var pl = p.global_position
	var d = goalPoint.distance_to(pl)
	return (1000 - d)+(p.frames/10.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	active_max = 75
	generation()
var lastBest = -1
func generation():
	idSpace = 0
	if best_score > 0:
		lastBest = best_score
		best_score = -1
	else:
		best_score = lastBest
	UI.clearLog()
	for i in range(active_max):
		var p = spawn()
		p.weightx = wx
		p.weighty = wy
		p.weight2x = w2x
		p.weight2y = w2y
		p.weight3x = w3x
		p.weight3y = w3y
		p.weight4x = w4x
		p.weight4y = w4y
		p.weight5 = w5
		p.randomizeWeights()
	x = []
	y = []
	x2= []
	y2= []
	x3= []
	y3= []
	x4= []
	y4= []
	v5= []
	scores = {}
	i2 = 0
onready var ui_left = $UI/VBoxContainer/StatsContainer/Left
onready var ui_fps  = $UI/VBoxContainer/StatsContainer/FPS
onready var ui_gen  = $UI/VBoxContainer/StatsContainer/Gen
func updateUI():
	ui_fps.text = str(Engine.get_frames_per_second())
	ui_left.text = str(len(active)) + "/" + str(active_max) + " left"
	ui_gen.text = "Generation " + str(gen)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var goalPoint = Vector2(0, 0)
func _process(delta):
	goalPoint = goal.global_position
	updateUI()
	if len(active) < 1:
		print("Gen " + str(gen) + " done. Best: " + str(best_score))
		generation()
		gen += 1
	if Input.is_action_just_pressed("dev_print"):
		print("Best score: " + str(best_score))
		print("wx: " + str(wx))
		print("wy: " + str(wy))
		print("w2x: " + str(w2x))
		print("w2y: " + str(w2y))
		print("w3x: " + str(w3x))
		print("w3y: " + str(w3y))
		print("w4x: " + str(w4x))
		print("w4y: " + str(w4y))
		print("w5 : " + str(w5))
	if Input.is_action_pressed("ui_accept"):
		goal.global_position = get_global_mouse_position()


func _on_Diezone_body_entered(body):
	if body is player:
		kill(body)


func _on_SpawnTimer_timeout():
	spawn()


func _on_Diezone_area_entered(area):
	if area is player:
		kill(area)
