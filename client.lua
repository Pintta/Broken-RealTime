local synced = false;
local h = 0
local m = 0
local s = 0
local looptime = 1000

CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Wait(0)
	end
	TriggerServerEvent("RealTime-Fivem:server:requesttime")
	while not synced do
		Wait(0)
	end
	TriggerEvent("RealTime-Fivem:client:override")
end)

RegisterNetEvent('RealTime-Fivem:client:serversync', function(hour, minute, second, loop)
	h = hour
	m = minute
	s = second
	if not synced then
		synced = true
		local loopwhole = 1000 / loop
		looptime = loopwhole % 1 >= 0.5 and math.ceil(loopwhole) or math.floor(loopwhole)
	end
end)

AddEventHandler("gametime:override", function()
	CreateThread(function()
		while true do
			Wait(10)
			NetworkOverrideClockTime(h, m, s)
		end
	end)
end)

CreateThread(function()
	while not synced do
		Wait(0)
	end
	while true do
		Wait(looptime)
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
	end
end)
