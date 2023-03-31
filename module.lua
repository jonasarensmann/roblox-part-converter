local HttpService = game:GetService("HttpService");

local module = {}

local url = "http://roblox-part-converter.vercel.app/api/models"
local key = "iegoesjiogjseiohnrdeiuohfngby"

function color3ToHex(color)
    local r = math.floor(color.R * 255)
    local g = math.floor(color.G * 255)
    local b = math.floor(color.B * 255)

    local hex = string.format("%02x%02x%02x", r, g, b)

    return hex
end

function convertInstances(Instances: table)
	local data = {parts = {}}
	for _, instance in pairs(Instances) do
		local instanceData = {
			position = {
				X = instance.Position.X,
				Y = instance.Position.Y,
				Z = instance.Position.Z
			},
			rotation = {
				X = instance.Rotation.X,
				Y = instance.Rotation.Y,
				Z = instance.Rotation.Z
			},
			color = color3ToHex(instance.color),
			size = {
				X = instance.Size.X,
				Y = instance.Size.Y,
				Z = instance.Size.Z
			},
		}
		table.insert(data.parts, instanceData)
	end
	return data;
end

function module:upload(Instances: table) 
	local data = convertInstances(Instances)

	local response, responseData
	pcall(function()
		response = HttpService:PostAsync(url .. "?key=" .. key, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson) 
		responseData = HttpService:JSONDecode(response)
	end)

	if responseData then
		return responseData.body
	end
end

return module;