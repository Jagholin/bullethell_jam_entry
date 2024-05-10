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

scripts has a subfolder called `scenes` that contains all the scripts that are attached to scenes.

