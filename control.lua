require("lib")
require("mod-support")

function update_players()
	for _,player in pairs(game.players) do
		if player and player.connected then
			update_player(player)
		end
	end
end

function update_player(player)
	if table_contains(global.players, player) then return end;
	if (player.controller_type ~= defines.controllers.character) then return end
	player.get_inventory(defines.inventory.character_main).clear()
	if global.start == false then
		global.start = true
		local inventory = player.character.get_inventory(defines.inventory.character_main);
		inventory.insert{name = "deep-mine", count = 4}
		inventory.insert{name = "stone-waterwell", count = 1}
		inventory.insert{name = "boiler", count = 1}
		inventory.insert{name = "steam-engine", count = 2}
		inventory.insert{name = "small-electric-pole", count = 2}
		inventory.insert{name = "small-electric-pole", count = 2}
	end
	table.insert(global.players, player)
end

function on_chunk_generate(event)
	local entities = event.surface.find_entities_filtered{area={{event.area.left_top.x,event.area.left_top.y}, {event.area.right_bottom.x, event.area.right_bottom.y}}, type="resource"}
    for _i,entity in pairs(entities) do
		if entity.prototype.resource_category ~= "basic-fluid" then
			entity.destroy()
		end
	end
	if global.setup == false then
		global.setup = true
		on_setup_mod_support()
	end
end

function on_player_join(event)
	local player = game.get_player(event.player_index)
	update_player(player)
end

function on_data_init()
	global = {}
	global.players = {}
	global.start = false
	global.setup = false
end

function on_mod_init()
	on_data_init()
	on_init_mod_support(global)
	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_disable_crashsite", true)
		remote.call("freeplay", "set_skip_intro", true)
	end
end

script.on_event({defines.events.on_player_changed_force, defines.events.on_force_created}, on_force_update)
script.on_event({defines.events.on_chunk_generated}, on_chunk_generate)
script.on_event({defines.events.on_player_joined_game, defines.events.on_player_created}, on_player_join)
script.on_init(on_mod_init)