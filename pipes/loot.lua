local hook
local _E

local update = function()
	if(LootFrame:IsShown() and oGlowClassic:IsPipeEnabled'loot') then
		for i=1, LOOTFRAME_NUMBUTTONS or 4 do
			local slotFrame = _G['LootButton' .. i]
			local slot = slotFrame.slot

			local itemLink
			if(slot) then
				itemLink = GetLootSlotLink(slot)
			end

			oGlowClassic:CallFilters('loot', slotFrame, _E and itemLink)
		end
	end
end

local enable = function(self)
	_E = true

	if(not hook) then
		LootFrameUpButton:HookScript("OnClick", update)
		LootFrameDownButton:HookScript("OnClick", update)

		hook = true
	end

	self:RegisterEvent('LOOT_OPENED', update)
	self:RegisterEvent('LOOT_SLOT_CLEARED', update)
	self:RegisterEvent('LOOT_SLOT_CHANGED', update)
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent('LOOT_OPENED', update)
	self:UnregisterEvent('LOOT_SLOT_CLEARED', update)
	self:UnregisterEvent('LOOT_SLOT_CHANGED', update)
end

oGlowClassic:RegisterPipe('loot', enable, disable, update, 'Loot frame', nil)
