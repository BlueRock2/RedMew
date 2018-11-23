Run the following upon startup to give bots, armor and items to place the tetris theme tune blueprint.

Use command /tpmode to teleport to the island to set it up.

This will give you the items you need:
```lua
/silent-command
  local player = game.player
  player.insert{name="power-armor-mk2", count = 1}
  local p_armor = player.get_inventory(5)[1].grid
  p_armor.put({name = "fusion-reactor-equipment"})
  p_armor.put({name = "fusion-reactor-equipment"})
  p_armor.put({name = "fusion-reactor-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "personal-roboport-mk2-equipment"})
  p_armor.put({name = "night-vision-equipment"})
  p_armor.put({name = "battery-mk2-equipment"})
  p_armor.put({name = "battery-mk2-equipment"})
  player.insert{name="decider-combinator", count = 143}
  player.insert{name="constant-combinator", count = 143}
  player.insert{name="programmable-speaker", count = 16}
  player.insert{name="arithmetic-combinator", count = 4}
  player.insert{name="substation", count = 4}
  player.insert{name="solar-panel", count = 15}
  player.insert{name="accumulator", count = 12}
```

This will make them non-griefable if you're standing in the centre of the music island:
```lua
/c
  local pos = game.player.position
  local area = {{pos.x - 40, pos.y - 80}, {pos.x + 40, pos.y + 80}}
  for _, e in pairs(game.player.surface.find_entities_filtered {area = area, force = 'player'}) do
      e.minable = false
      e.destructible = false
  end
```


Blueprint for the speaker setup to play the tetris theme:
```
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
```