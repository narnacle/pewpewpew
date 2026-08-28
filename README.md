# CHANGELOG.md

All notable changes to the **PewPewPew (Asteroids Clone)** GameMaker project are documented below.

---

## [1.2.0] - Game Loop & HUD

### Added

* **Score System & HUD**:
* Added `points` tracking variable initialized to `0` inside `obj_game`.
* Added `Draw GUI` event in `obj_game` to display current score at position `(10, 10)`.
* Added `+50 points` reward to `obj_game.points` upon destroying any rock instance.


* **Game Over & Restart Flow**:
* Added player death particle effect (`ef_firework`) on `obj_player` collision with `obj_rock`.
* Added 2-second delay (120 frames via `alarm[0]`) assigned to `obj_game` upon player destruction.
* Added room restart action (`room_restart()`) in `obj_game`'s `Alarm 0` event.
* Placed `obj_game` instance into room layout to manage background systems.



---

## [1.1.0] - Combat & Asteroid Mechanics

### Added

* **Shooting System**:
* Mouse control: Left click creates an instance of `obj_bullet` at player coordinates.
* Bullet initial state: Moves forward at speed `10` in direction of player orientation (`image_angle`).
* Memory cleanup: Automatically destroys `obj_bullet` instances upon leaving room boundary (`Outside Room` event).


* **Asteroid Behavior**:
* Random movement speed (`1`) and direction (`0`–`360` degrees) assigned on creation.
* Added continuous rotation (`image_angle += 1` per frame).
* Added Screen Wrapping with an extended 100px boundary margin.


* **Collision Logic (`obj_rock` vs `obj_bullet`)**:
* Added bullet destruction and medium white explosion effect on hit.
* Splitting logic: Shooting a large rock splits it into two small rocks (`spr_rock_small`).
* Respawn system: Destroyed small rocks respawn outside room boundary (`x = -48`) as large rocks if rock count `< 12`.
* Hard cap: Completely destroys rock instances if total count reaches 12.



---

## [1.0.0] - Initial Setup & Player Movement

### Added

* **Project Setup**:
* Initialized project using the `Space Rocks` asset template.
* Configured Room size to square layout `1024x1024`.
* Created base objects with designated sprites:
* `obj_player` (`spr_player`)
* `obj_bullet` (`spr_bullet`)
* `obj_rock` (`spr_rock`)
* `obj_game` (Invisible global manager)


* Placed 1 player instance and 6 rock instances on the `Instances` room layer.


* **Player Movement (`Step` Event)**:
* Forward acceleration via Up Arrow key using `motion_add(image_angle, 0.1)`.
* Turning mechanics: Left Arrow key (`image_angle += 4`) and Right Arrow key (`image_angle -= 4`).
* Added vertical and horizontal screen wrapping (`move_wrap`).