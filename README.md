## Project

this is a jam entry for the bullethell game jam 2024

## Requirements

Godot 4.2.2

## Folder structure

Currently this thing has a simple folder structure as follows:

- `asset_sources/`: Contains all the source files for the assets. Has `.gdignore` file which makes this folder invisible to the **godot** engine This is where you should put the files you use to create the assets in the `assets/` folder. Examples of files that should be here are `.blend` files, `.psd` files etc.
- `assets/`: Contains all the assets for the game, ready to be imported into Godot.
- `build/`: Contains the exported godot project. Is intended to be empty.
- `scenes/`: Contains all the scenes for the game.
- `scripts/`: Contains all the scripts for the game.
- `resources/`: Contains godot resources(instances of classes derived from `Resource`), each in their own folder.
- `credits.txt`: Let's keep track of any external assets used and their license.
 
scripts also has its own subfolders:
- `scenes` that contains all the scripts that are attached to scenes.
- `resources` contains all scripts that define new godot resources (derived from `Resource`).

## About collision layers

Bullets scan different collision layers depending on whether its a player bullet or an enemy bullet. The player bullet scans the `enemy` layer and the enemy bullet scans the `player` layer. This is to prevent the bullets from colliding with the entity that spawned them as well as limit necessary calculations. In addition, the bullets themselves are not on any layer.

`player` layer is layer 1 and `enemy` layer is layer 2.

