# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2025-03-05

### Added
    - Added `TextRendererComponent` to write text on screen using a object.
    - Added `TransformComponent` to gave more flexibility while creating objects.
    - Added `Loveplay.assetsPool` to handle assets during the game lifetime.
    - Added event hook for draw: `onDraw`.


### Changed
    - Changed `Vec2.ZERO` `Vec2.ONE` `Vec2.UP` `Vec2.DOWN` `Vec2.LEFT` `Vec2.RIGHT` to be static classes instead of a function. 
    - changed the hook name for events, now every event starts with keyword `on` instead the old `__`.

### Removed
    - The object created with `Loveplay.object` no longer have the `pos` attribute implemented, use the `TransformComponent` to add `Vec2` positions and functions to change the object position.