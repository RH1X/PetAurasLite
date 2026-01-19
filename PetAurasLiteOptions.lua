-- ===========================
-- PetAurasLite Options Frame
-- ===========================
PetAurasLiteOptions = CreateFrame("Frame", "PetAurasLiteOptionsFrame", UIParent, "BackdropTemplate")
PetAurasLiteOptions:SetSize(420, 220)
PetAurasLiteOptions:SetPoint("CENTER")
PetAurasLiteOptions:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 12,
})
PetAurasLiteOptions:SetBackdropColor(0,0,0,1)
PetAurasLiteOptions:Hide()
PetAurasLiteOptions:SetMovable(true)
PetAurasLiteOptions:EnableMouse(true)
PetAurasLiteOptions:RegisterForDrag("LeftButton")
PetAurasLiteOptions:SetScript("OnDragStart", function(self) self:StartMoving() end)
PetAurasLiteOptions:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

-- Close button
local closeBtn = CreateFrame("Button", nil, PetAurasLiteOptions, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -4, -4)

-- Title
local title = PetAurasLiteOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("PetAurasLite Settings")

-- Helper: Header
local function CreateHeader(text, yOffset)
    local header = PetAurasLiteOptions:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    header:SetPoint("TOPLEFT", 16, yOffset)
    header:SetText(text)
    return header
end

-- Helper: Checkbox
local function CreateCheckbox(label, x, y, onClick)
    local cb = CreateFrame("CheckButton", nil, PetAurasLiteOptions, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", x, y)
    cb.text:SetText(label)
    cb:SetScript("OnClick", onClick)
    return cb
end

local presetValues = {3,5,8,10}

-- Buffs
CreateHeader("Buff Icons", -50)
local buffCheckboxes = {}
for i, count in ipairs(presetValues) do
    buffCheckboxes[i] = CreateCheckbox(count.." Slots", 40 + (i-1)*80, -80, function(self)
        for _, cb in ipairs(buffCheckboxes) do
            if cb ~= self then cb:SetChecked(false) end
        end
        SetBuffCount(count)
    end)
    if PetAurasLiteDB.buffCount == count then
        buffCheckboxes[i]:SetChecked(true)
    end
end

-- Debuffs
CreateHeader("Debuff Icons", -130)
local debuffCheckboxes = {}
for i, count in ipairs(presetValues) do
    debuffCheckboxes[i] = CreateCheckbox(count.." Slots", 40 + (i-1)*80, -160, function(self)
        for _, cb in ipairs(debuffCheckboxes) do
            if cb ~= self then cb:SetChecked(false) end
        end
        SetDebuffCount(count)
    end)
    if PetAurasLiteDB.debuffCount == count then
        debuffCheckboxes[i]:SetChecked(true)
    end
end
