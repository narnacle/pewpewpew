# PewPewPew

PewPewPew is a Windows build of a GameMaker Space Rocks / Asteroids-style arcade game. Fly, shoot, split rocks, score points, and use the main menu to start, quit, or view controls.

## Download

Download the latest Windows executable from the GitHub releases page:

https://github.com/narnacle/pewpewpew/releases/latest

Current release:

https://github.com/narnacle/pewpewpew/releases/tag/v1.3.0

Direct Windows download:

https://github.com/narnacle/pewpewpew/releases/download/v1.3.0/PewPewPew.exe

## Release Notes

### [1.3.0] - Main Menu & UI System

Added:

* Main menu room architecture:
  * Added dedicated `RM_menu` room set as the project's primary entry room.
  * Configured a clear initial instance layer with no active gameplay entities.
* UI asset pipeline:
  * Created custom `fnt_menu` font asset at size 40 with anti-aliasing disabled.
  * Added button sprite template configured with `Middle Center` origin for text alignment.
* Object-oriented UI hierarchy:
  * Created `obj_button_parent` base controller for rendering, alignment, hover states, and click mechanics.
  * Added parent variable `button_text` for button labeling.
  * Added centered text positioning logic with drawing property resets in the `Draw` event.
* Hover and click animations:
  * Mouse Enter and Leave handling toggles instance alpha between `0.6` and `1.0`.
  * Click effect adds positional offset feedback synchronized with `Alarm 0`.
* Menu buttons:
  * `obj_button_play` inherits from the parent button and transitions to `RM_game` after `Alarm 0`.
  * `obj_button_quit` inherits from the parent button and exits through `game_end()`.
  * `obj_button_help` inherits from the parent button and toggles `obj_controls` visibility.
* Help overlay:
  * Added `obj_controls` renderer for displaying controls with newline formatting.
  * Placed the overlay dynamically at screen center when toggled.

### [1.2.0] - Game Loop & HUD

Added:

* Score system and HUD:
  * Added `points` tracking variable initialized to `0` inside `obj_game`.
  * Added `Draw GUI` event in `obj_game` to display current score at `(10, 10)`.
  * Added `+50 points` reward to `obj_game.points` when a rock is destroyed.
* Game over and restart flow:
  * Added player death particle effect (`ef_firework`) on `obj_player` collision with `obj_rock`.
  * Added 2-second delay through `alarm[0]` on `obj_game` after player destruction.
  * Added room restart action (`room_restart()`) in `obj_game`'s `Alarm 0` event.
  * Placed `obj_game` instance into the room layout to manage background systems.

### [1.1.0] - Combat & Asteroid Mechanics

Added:

* Shooting system:
  * Left click creates an instance of `obj_bullet` at the player coordinates.
  * Bullets move forward at speed `10` in the player's facing direction (`image_angle`).
  * Bullets destroy themselves when leaving the room boundary.
* Asteroid behavior:
  * Random movement speed and direction from `0` to `360` degrees assigned on creation.
  * Added continuous rotation with `image_angle += 1` per frame.
  * Added screen wrapping with an extended 100px boundary margin.
* Collision logic for `obj_rock` and `obj_bullet`:
  * Added bullet destruction and medium white explosion effect on hit.
  * Shooting a large rock splits it into two small rocks (`spr_rock_small`).
  * Destroyed small rocks respawn outside the room boundary as large rocks when rock count is below `12`.
  * Hard cap destroys rock instances completely when the total count reaches `12`.

### [1.0.0] - Initial Setup & Player Movement

Added:

* Project setup:
  * Initialized project using the `Space Rocks` asset template.
  * Configured room size to square layout `1024x1024`.
  * Created base objects with designated sprites:
    * `obj_player` (`spr_player`)
    * `obj_bullet` (`spr_bullet`)
    * `obj_rock` (`spr_rock`)
    * `obj_game` as invisible global manager
  * Placed 1 player instance and 6 rock instances on the `Instances` room layer.
* Player movement:
  * Forward acceleration via Up Arrow using `motion_add(image_angle, 0.1)`.
  * Turning with Left Arrow (`image_angle += 4`) and Right Arrow (`image_angle -= 4`).
  * Added vertical and horizontal screen wrapping with `move_wrap`.

## Maintainer Notes

The executable is distributed through GitHub Releases instead of being committed to the repository. Local `.exe` builds are ignored by Git.

To publish the current build again from this workspace:

```powershell
.\scripts\publish-release.ps1 -Version v1.3.0 -ExePath .\PewPewPew.exe
```
