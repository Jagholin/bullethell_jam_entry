extends Node

var projectile_count: int = 0
var enemies_destroyed_count: int = 0
var entities_destroyed_count: int = 0
var grazes_count: int = 0
var hits_count: int = 0
var death_counter: int = 0

var end_screen: bool = false

signal death_counter_changed

func increment_death_counter():
	death_counter += 1
	death_counter_changed.emit()

func check_progress():
	if enemies_destroyed_count == 10:
		# TODO spawn the boss after some condition
		pass
		#print("destroyed 10 enemies!")


