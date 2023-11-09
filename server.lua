local h = tonumber(os.date("%H"))
local m = tonumber(os.date("%M"))
local s = tonumber(os.date("%S"))

local RockstarLogic = 1
local loopwhole = 1000 / RockstarLogic
local looptime = loopwhole % 1 >= 0.5 and math.ceil(loopwhole) or math.floor(loopwhole)

CreateThread(function()
	local timer = 0
	while true do
		Wait(looptime)
		timer = timer + 1
		s = s + 1
		if s >= 60 then
			s = 0
			m = m + 1
		end
		if m >= 60 then
			m = 0
			h = h + 1
		end
		if h >= 24 then
			h = 0
		end
		if timer >= 60 * gta_seconds_per_real_second then
			timer = 0
			TriggerClientEvent('op-RealTime:client:serversync', -1, h, m, s, gta_seconds_per_real_second)
		end
	end
end)

RegisterServerEvent('op-RealTime:server:requesttime', function()
	TriggerClientEvent('op-RealTime:client:serversync', -1, h, m, s, gta_seconds_per_real_second)
end)
