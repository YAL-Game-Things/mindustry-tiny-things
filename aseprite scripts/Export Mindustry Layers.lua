--[[
	Auto-exports each root layer to <sprite path>-<layer name>.png
	A layer called "default" will have no suffix.
	NB! Names are case-sensitive!
--]]
function info(title, text)
	Dialog(title)
	:label{label=text}
	:newrow()
	:button{ id="ok", text="&OK", focus=true }
	:show()
end
local spr = app.activeSprite
if spr == nil then
	info("Error", "No sprite is open!")
	return 1
elseif not spr.filename:find("[/\\]") then
	info("Error", "Please save the sprite to a file first!")
	return 1
end
local pathPrefix = spr.filename:match("(.+)%..+")
for _, layer in ipairs(spr.layers) do
	if not layer.name:find('[/\\:*"?<>|]') then
		local layerPath = pathPrefix
		if layer.name ~= "default" then
			layerPath = layerPath .. "-" .. layer.name
		end
		layerPath = layerPath .. ".png"
		app.command.ExportSpriteSheet{
			ui=false,
			askOverwrite=false,
			type=SpriteSheetType.HORIZONTAL,
			columns=0,
			rows=0,
			width=0,
			height=0,
			bestFit=false,
			textureFilename=layerPath,
			borderPadding=0,
			shapePadding=0,
			innerPadding=0,
			trim=false,
			extrude=false,
			openGenerated=false,
			layer=layer.name,
			tag="",
			splitLayers=false,
			--listLayers=layer,
			listTags=true,
			listSlices=true,
		}
	end
end