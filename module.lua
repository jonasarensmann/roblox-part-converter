local HttpService = game:GetService("HttpService");

local module = {}

local url = "http://localhost:3000/api/models"
local key = "iegoesjiogjseiohnrdeiuohfngby"

function rgbToHex(rgb: table) 
	local hexadecimal = ''

	for key, value in pairs(rgb) do
		local hex = ''
		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end
		if(string.len(hex) == 0)then
			hex = '00'
		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end
	return hexadecimal
end

function convertInstances(Instances: table)
	local data = {}
	for _, instance in pairs(Instances) do
		local instanceData = {
			position = {
				x = instance.Position.X,
				y = instance.Position.Y,
				z = instance.Position.Z
			},
			rotation = {
				x = instance.Rotation.X,
				y = instance.Rotation.Y,
				z = instance.Rotation.Z
			},
			color = rgbToHex({R = instance.Color.R, G = instance.Color.G, B = instance.Color.B}),
			size = {
				x = instance.Size.X,
				y = instance.Size.Y,
				z = instance.Size.Z
			},
		}
		table.insert(data, instanceData)
	end
end

function module:upload(Instances: table) 
	local data = convertInstances(Instances)

	local response, responseData
	pcall(function()
		response = HttpService:PostAsync(url + "?key=" + key, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson) 
		responseData = HttpService:JSONDecode(response)
	end)

	if responseData then
		return responseData.body
	end
end

return module;