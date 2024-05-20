extends StateBossBase
class_name StateFiring

@export var bullet_configs: Array[ProjectileSpawnerConfigResource]
@export var spawner: ProjectileSpawnerComponent
@export var next_state: State
@export var duration: float

var old_configs: Array[ProjectileSpawnerConfigResource]
var old_active: bool
var accumulated_time: float

func enter():
    super.enter()
    old_configs = spawner.bullet_configs
    old_active = spawner.active
    spawner.bullet_configs = bullet_configs
    spawner.active = true

func exit():
    super.exit()
    spawner.bullet_configs = old_configs
    spawner.active = old_active

func process_frame(delta: float) -> String:
    super.process_frame(delta)
    accumulated_time += delta
    if accumulated_time >= duration:
        return next_state.name
    else:
        return ""
