extends Node

var projectile_count: int = 0
var enemies_destroyed_count: int = 0
var entities_destroyed_count: int = 0
var grazes_count: int = 0
var hits_count: int = 0

func check_progress():
	if enemies_destroyed_count == 10:
		# TODO spawn the boss after some condition
		print("destroyed 10 enemies!")
