local h = tonumber(os.date("%H"))
local m = tonumber(os.date("%M"))
local s = tonumber(os.date("%S"))

CreateThread(function()
	local timer = 0
	while true do
		Wait(1000)
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
		if timer >= 60 then
			timer = 0
			TriggerClientEvent('OikeaKello:TsekkaaAika', -1, h, m, s, 1)
		end
	end
end)

RegisterServerEvent('OikeaKello:KysyAika', function()
	TriggerClientEvent('OikeaKello:TsekkaaAika', -1, h, m, s, 1)
end)
