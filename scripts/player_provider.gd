extends Node

var player: Player:
    set(newValue):
        if player == newValue:
            return
        player = newValue
        player_changed.emit(player)

signal player_changed(player: Player)

func on_player_initialized(cb: Callable):
    if not player:
        await player_changed
    cb.call(player)

func set_player(new_player: Player):
    player = new_player
