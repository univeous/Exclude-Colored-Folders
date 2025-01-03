# Exclude Colored Folders

A Godot plugin for excluding folders with specific color markers during export.

## Features

- Configure different export behaviors for folders with different colors:
  - Do not export (always)
  - Do not export (release builds only)
  - Do not export (debug builds only) 
  - Export normally (default)

## Usage

1. Download and install the addon(download the repo and unzip or use package manager like [gd-plug](https://github.com/imjp94/gd-plug) or [godotenv](https://github.com/chickensoft-games/GodotEnv))
2. Enable the addon in `Project Settings`
3. Find `Addons > Exclude Colored Folders` category in `Project Settings`
4. Choose desired export behavior for each color
5. Set color markers for folders in the file tab (right click on the folder and select `Set Folder Color`)

When exporting, the plugin will automatically exclude folders based on settings