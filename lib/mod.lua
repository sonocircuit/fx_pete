-- pEte - a simple freeze delay for fx mod
-- v1.0 @sonoCircuit

local fx = require 'fx/lib/fx'
local md = require 'core/mods'

local FxPete = fx:new{subpath = "/fx_pete"}

local rate_options = {"1/16", "1/12", "3/32", "1/8", "1/6", "3/16", "1/4","1/3", "3/8", "1/2", "2/3", "3/4", "1"}
local rate_values = {1/16, 1/12, 3/32, 1/8, 1/6, 3/16, 1/4, 1/3, 3/8, 1/2, 2/3, 3/4, 1}

local function set_param(key, val)
  osc.send({ "localhost", 57120 }, "/fx_pete/set", {key, val})
end

function FxPete:add_params()
    params:add_group("fx_pete", "fx pEte", 4)
    FxPete:add_slot("fx_pete_slot", "slot")

    params:add_option("fx_pete_rate", "rate", rate_options, 1)
    params:set_action("fx_pete_rate", function(idx) set_param('frzTime', rate_values[idx] * clock.get_beat_sec() * 4) end)

    params:add_binary("fx_pete_gate", "freeze", "momentary")
    params:set_action("fx_pete_gate", function(state) set_param('frzGate', state) end)
end

md.hook.register("script_post_init", "fx pEte mod post init", function() FxPete:add_params() end)

return FxPete
