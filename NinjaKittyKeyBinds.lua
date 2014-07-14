NinjaKittyKeyBinds = LibStub("AceAddon-3.0"):NewAddon("NinjaKittyKeyBinds", "AceConsole-3.0")
NinjaKittyKeyBinds._G = _G

setfenv(1, NinjaKittyKeyBinds)

local string, math, pairs, ipairs = _G.string, _G.math, _G.pairs, _G.ipairs
local UIParent, CreateFrame = _G.UIParent, _G.CreateFrame
local LibStub = _G.LibStub
local NinjaKittyKeyBinds = _G.NinjaKittyKeyBinds

---- < MACROS > ------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- Used to have "/cancelaura [form:3]Incarnation: King of the Jungle".

local macros = {
  {
    key = "`",
    init = function(self)
      self.button:SetAttribute("downbutton", "RightButton")
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", "/use Stampeding Roar")
      self.button:SetAttribute("*macrotext2", "/cancelaura Dash\n/use Stampeding Roar")
      self.button:RegisterForClicks("AnyDown", "AnyUp")
    end,
  },
  { key = "SHIFT-`" },
  { key = "ALT-`" },
  { -- Used to "/cancelform [form:5,flying]" here, too.
    key = "1",
    init = function(self)
      self.button:SetAttribute("downbutton", "RightButton")
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", "/use Dash")
      self.button:SetAttribute("*macrotext2", "/cancelaura Stampeding Roar\n/use Dash")
      self.button:RegisterForClicks("AnyDown", "AnyUp")
    end,
  },
  { key = "SHIFT-1" },
  { key = "ALT-1" },
  { key = "2", text = "/use Might of Ursoc" },
  { key = "SHIFT-2", text = "/use Nature's Grasp" },
  {
    key = "ALT-2", text =
      "/cancelaura Dispersion\n" ..
      "/cancelaura Divine Shield\n" ..
      "/cancelaura Hand of Protection\n" ..
      "--/cancelaura Prowl",
  },
  {
    key = "3", text =
      "/use Cyclone",
  },
  --[[
  {
    key = "SHIFT-3", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [noform:1]Bear Form",
  },
  ]]
  {
    key = "SHIFT-3", text =
      "/use [@focus]Cyclone",
  },
  { -- "/castsequence [@player] Mark of the Wild,Foo" seems to reset on death.
    key = "ALT-3", text =
      "/cancelaura Goblin Glider\n" ..
      "/castsequence [@player] Mark of the Wild,Foo\n" ..
      "/userandom [nomounted,flyable]Silver Covenant Hippogryph,Cenarion War Hippogryph\n" ..
      "/userandom [nomounted,noflyable]Silver Covenant Hippogryph,Cenarion War Hippogryph,Swift Moonsaber," ..
        "Fossilized Raptor,Winterspring Frostsaber\n" ..
      "/use 15\n" ..
      "/dismount"
  },
  {
    key = "4", text =
      "/use [@mouseover,help,nodead][help,nodead][@player]Healing Touch",
  },
  {
    key = "SHIFT-4", text =
      "/use [@party1]Healing Touch\n" ..
      "/use [@party1]1",
  },
  {
    key = "ALT-4", text =
      "/use [@party2]Healing Touch\n" ..
      "/use [@party2]1",
  },
  --[[
  {
    key = "ALT-4", text =
      "/use Conjured Mana Buns\n" ..
      "/use Conjured Mana Pudding\n" ..
      "/use Cobo Cola\n" ..
      "/use Golden Carp Consomme",
  },
  ]]
  --[[
  {
    key = "5", text =
      "/use Renewal\n" ..
      "/use [@mouseover,help,nodead]Cenarion Ward\n" ..
      "/use [@player]Cenarion Ward",
  },
  {
    key = "SHIFT-5", text =
      "/use [@mouseover,help,nodead]Cenarion Ward\n" ..
      "/use [help,nodead]Cenarion Ward;[@party1,exists,nodead]Cenarion Ward",
  },
  {
    key = "ALT-5", text =
      "/use [@mouseover,help,nodead]Cenarion Ward\n" ..
      "/use [help,nodead]Cenarion Ward;[@party2,exists,nodead]Cenarion Ward",
  },
  ]]
  {
    key = "5", text =
      "/use [@mouseover,help,nodead][help,nodead][@player]Rejuvenation",
  },
  {
    key = "SHIFT-5", text =
      "/use [@party1]Rejuvenation\n" ..
      "/use [@party1]1",
  },
  {
    key = "ALT-5", text =
      "/use [@party2]Rejuvenation\n" ..
      "/use [@party2]1",
  },
  {
    key = "6", text =
      "/use [@mouseover,help,nodead][help,nodead][@player]Cenarion Ward",
  },
  {
    key = "SHIFT-6", text =
      "/use [@party1]Cenarion Ward\n" ..
      "/use [@party1]1",
  },
  {
    key = "ALT-6", text =
      "/use [@party2]Cenarion Ward\n" ..
      "/use [@party2]1",
  },
  --[[
  {
    key = "6", text =
      "/castsequence [mod:shift]reset=1 0,Tranquility\n" ..
      "/use [mod:shift]Heart of the Wild;Might of Ursoc\n" ..
      "/use [nomod:shift]Healthstone",
  },
  {
    key = "ALT-6", text =
    "/use Tranquility",
  },
  ]]
  --[[
  {
    key = "TAB", text =
    "/use [form:1]Frenzied Regeneration" .. '\n' ..
    "/cancelform [form]" .. '\n' ..
    "/dismount [mounted]" .. '\n' ..
    "/stopcasting",
  },
  ]]
  {
    key = "TAB", text =
      "/cancelaura Prowl\n" .. -- When we want to Shadowmeld, we want to Shadowmeld! We don't want to be told that "a
      "/use Shadowmeld",       -- more powerful spell is already active".
  },
  { key = "ALT-TAB" },
  { key = "Q", text =
    "/use [noform:5]13",
  },
  { key = "ALT-Q" },
  --[[
  { key = "W", text =
      "/use [@mouseover,help,nodead]Healing Touch;[@mouseover,help]Revive\n" ..
      "/use [@player,nomod:shift]Healing Touch;[help,nodead]Healing Touch;[help]Revive;" ..
        "[@party1,exists,nodead]Healing Touch;[@party1,exists]Revive",
  },
  ]]
  {
    key = "W", text =
      "/use Tiger's Fury\n" ..
      "/use [form:3]10\n" ..
      "/use [form:3]14",
  },
  --{ key = "SHIFT-W", text = "/use Heart of the Wild" },
  {
    key = "SHIFT-W", specs = { [103] = true, }, text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use Incarnation\n" ..
      "/use Nature's Vigil\n" ..
      "/castsequence [form:3]reset=1 0,Tiger's Fury\n" ..
      "/castsequence [form:3]reset=1 0,14\n" ..
      "/castsequence [form:3]reset=1 0,10\n" ..
      "/castsequence [form:3]reset=1 0,Berserk\n" ..
      "/castsequence [form:3]reset=1 0,Berserking",
  },
  --[[
  { key = "ALT-W", text =
      "/use [@mouseover,help,nodead]Healing Touch;[@mouseover,help]Revive\n" ..
      "/use [help,nodead]Healing Touch;[help]Revive;[@party2,exists,nodead]Healing Touch;" ..
        "[@party2,exists]Revive",
  },
  ]]
  {
    key = "ALT-W", text =
      "/use Conjured Mana Buns\n" ..
      "/use Conjured Mana Pudding\n" ..
      "/use Cobo Cola\n" ..
      "/use Golden Carp Consomme",
  },
  --[[
  {
    key = "E", text =
      "/use [harm,nodead,nomod:shift][@focus,harm,nodead,mod:shift]Cyclone\n" ..
      "/stopmacro [exists][mod:shift]\n" ..
      "/targetlasttarget\n" ..
      "/startattack [combat,nostealth]",
  },
  ]]
  {
    key = "E", text =
      "/stopcasting\n" ..
      "/use Typhoon",
  },
  { key = "SHIFT-E", text = "/use [exists]Mangle" },
  { key = "ALT-E", text = "/use [@mouseover,help,nodead][@player]Mark of the Wild", },
  --[[
  {
    key = "R", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [@mouseover,help,nodead]Rejuvenation;[@mouseover,help]Rebirth\n" ..
      "/use [@player,nomod:shift]Rejuvenation;[help,nodead]Rejuvenation;[help]Rebirth;" ..
        "[@party1,exists,nodead]Rejuvenation;[@party1,exists]Rebirth",
  },
  ]]
  {
    key = "R", specs = { [103] = true }, text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [noform:3]Cat Form;Savage Roar",
  },
  {
    key = "SHIFT-R", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [noform:1]Bear Form",
  },
  { -- TODO.
    key = "ALT-R", text =
      "",
  },
  --[[
  {
    key = "ALT-R", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [@mouseover,help,nodead]Rejuvenation;[@mouseover,help]Rebirth\n" ..
      "/use [help,nodead]Rejuvenation;[help]Rebirth;[@party2,exists,nodead]Rejuvenation;[@party2,exists]Rebirth",
  },
  ]]
  { key = "ALT-T", text = "/use !Travel Form", },
  {
    key = "Y", specs = { [102] = true, [103] = true, [104] = true },
    text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [@mouseover,help,nodead]Remove Corruption\n" ..
      "/use [@player,nomod][exists,help,nodead][@party1,exists,mod:shift][@party2,exists,mod:alt]Remove Corruption\n" ..
      "/use 1",
  },
  {
    key = "ESCAPE",
    text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [form:1]!Bear Form;[form:3]!Cat Form;[swimming]!Aquatic Form;[form:5][flyable,nocombat,outdoors]" ..
        "!Swift Flight Form;[outdoors]!Travel Form;!Cat Form",
  },
  { key = "SHIFT-ESCAPE" },
  { key = "ALT-ESCAPE" },
  {
    key = "A",
    text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/cancelform [form]\n" ..
      "/dismount [mounted]",
  },
  { key = "SHIFT-A" },
  { key = "ALT-A" },
  --[[
  {
    key = "S",
    specs = { [103] = true, },
    text =
      "/use [form:1]Frenzied Regeneration" .. '\n' ..
      "/use [mod:shift]Incarnation;[form:3]Tiger's Fury" .. '\n' ..
      "/use [mod:shift]Nature's Vigil" .. '\n' ..
      "/use [nomod:shift,form:3]10" .. '\n' ..
      "/use [nomod:shift,form:3]14" .. '\n' ..
      "/castsequence [mod:shift,form:3]reset=1 0,Tiger's Fury" .. '\n' ..
      "/castsequence [mod:shift,form:3]reset=1 0,14" .. '\n' ..
      "/castsequence [mod:shift,form:3]reset=1 0,10" .. '\n' ..
      "/castsequence [mod:shift,form:3]reset=1 0,Berserk" .. '\n' ..
      "/castsequence [mod:shift,form:3]reset=1 0,Berserking",
  },
  ]]
  { key = "S", text =
      "/stopcasting\n" ..
      "/use [form:2/4][@mouseover,help,noform][@mouseover,harm,form:1/3][help,noform][harm,form:1/3][@party1,noform]Wild Charge\n" ..
      "/use [@party1,help,noform]1\n" ..
      "/use Displacer Beast",
  },
  {
    key = "SHIFT-S", text =
      "/stopcasting\n" ..
      "/use [@focus,noform:2/4]Wild Charge",
  },
  { key = "ALT-S", text = "/focus arena1" },
  {
    key = "D",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when [harm].
        "/stopcasting\n" ..
        "/use [@party2,noform]Wild Charge\n" ..
        "/use [@party2,noform]1\n" ..
        "/use [@mouseover,harm,form:1/3][harm,form:1/3]Skull Bash"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/stopcasting\n" ..
        "/use [@party2,noform]Wild Charge\n" ..
        "/use [@party2,noform]1\n" ..
        "/stopmacro [@party2,help,noform:3]\n" ..
        "/use [@mouseover,harm,form:1/3]Skull Bash\n" ..
        "/stopmacro [@mouseover,harm,form:1/3]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use [form:1/3]Skull Bash\n" ..
        "/cleartarget"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", self.button, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "SHIFT-D", text = "/use [@focus,harm]Skull Bash" },
  { key = "ALT-D", text = "/focus arena2" },
  {
    key = "F",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      --[[
      self.button:SetAttribute("*macrotext1", -- Used when [noform:3].
        "/use Cat Form"
      )
      ]]
      self.button:SetAttribute("*macrotext2", -- Used when [harm].
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [noform:3]Cat Form;[@mouseover,harm]Mangle;[mod:shift]Ravage;Shred"
      )
      self.button:SetAttribute("*macrotext3", -- Used when [noexists][noharm].
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [noform:3]Cat Form;[@mouseover,harm]Mangle\n" ..
        "/stopmacro [noform:3][@mouseover,harm]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use [mod:shift,harm]Ravage;[harm]Mangle\n" ..
        "/cleartarget"
      )
      -- Our snippets get these arguments: self, button, down.  See
      -- "http://wowprogramming.com/utils/xmlbrowser/live/FrameXML/SecureTemplates.lua" and "Iriel�s Field Guide to
      -- Secure Handlers".
      _G.SecureHandlerWrapScript(self.button, "OnClick", self.button, [[
        --if GetBonusBarOffset() ~= 3 then
          if UnitExists("target") and PlayerCanAttack("target") then
            return "RightButton"
          else
            return "MiddleButton"
          end
        --end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "ALT-F", text =
    "/focus arena3",
  },
  { key = "G", text =
      "/use [form:3,mod:shift]Ferocious Bite;[form:3]Rip;[form:1,nomod:shift]Thrash;" ..
        "[form:1]Swipe;[@focus,noform,mod:shift]Soothe;[@target,noform]Soothe",
  },
  { key = "ALT-G", text = "/focus arena4" },
  { key = "H", text =
    "/use [harm,nodead,nomod:shift][@focus,harm,nodead,mod:shift]Hibernate",
  },
  { key = "ALT-H", text = "/focus arena5" },
  {
    key = "Z",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when [harm].
        "/cancelform [form:5,flying]\n" ..
        "/use !Prowl\n" ..
        "/use [stealth]Pounce"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/cancelform [form:5,flying]\n" ..
        "/use !Prowl\n" ..
        "/stopmacro [nostealth]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use Pounce\n" ..
        "/cleartarget"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", self.button, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end
  },
  { key = "ALT-Z" },
  --[[
  {
    key = "X", text =
      "/use Tiger's Fury\n" ..
      "/use [form:3]10\n" ..
      "/use [form:3]14",
  },
  ]]
  { key = "X", text = "/use Survival Instincts" },
  --[[
  {
    key = "SHIFT-X",
    specs = { [103] = true, },
    text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use Nature's Vigil\n" ..
      "/use [form:3]Tiger's Fury\n" ..
      "/use [form:3]14\n" ..
      "/use [form:3]10\n" ..
      "/use [form:3]Berserk\n" ..
      "/use [form:3]Berserking",
  },
  ]]
  { key = "SHIFT-X", text = "/use Barkskin" },
  {
    key = "ALT-X", text =
      "/use [@mouseover,help,nodead][help,nodead][@player]Innervate",
  },
  { key = "V", text = "/use Symbiosis" },
  {
    key = "SHIFT-V",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when [harm].
        "/use [@mouseover,harm][]Rake"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/use [@mouseover,harm]Rake\n" ..
        "/stopmacro [@mouseover,harm]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use Rake\n" ..
        "/cleartarget"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", self.button, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "ALT-C", text = "/use [@focus]Force of Nature" },
  { key = "ALT-V" }, -- FREE!
  { key = "B", text = "/use Entangling Roots" },
  { key = "SHIFT-B", text = "/use [@focus]Entangling Roots" },
  { key = "ALT-B", text = "/use Moonfire" },
  {
    key = "N", text =
      --"/use [form:3,mod:shift]Swipe;[form:3]Thrash;[form:1]Growl" .. '\n' ..
      "/use [form:1/3,mod:shift]Swipe;[form:1/3]Thrash\n" ..
      "/startattack [harm,nodead,form:1/3]",
  },
  { key = "ALT-N" },
  -- Can't target totems: Healing Stream Totem, Windwalk Totem, Earthbind Totem, Earthgrab Totem, Mana Tide Totem,
  -- Healing Tide Totem, Capacitor Totem, Spirit Link Totem, ...
  { key = "ALT-MOUSEWHEELUP", text =
      "/targetexact Psyfiend\n" ..
      "/startattack [exists,harm]\n" ..
      "/use [exists,harm]Wild Charge\n" ..
      "/use [exists,harm]Mangle",
  },
  { key = "ALT-MOUSEWHEELDOWN", text =
      "/targetexact Wild Mushroom\n" ..
      "/targetexact Psyfiend\n" ..
      "/startattack [exists,harm]\n" ..
      "/use [exists,harm]Skull Bash",
  },
  { key = "SHIFT-BUTTON4", text = "/focus", },
  { key = "BUTTON5", text =
      "/targetfriendplayer [nomod:shift]\n" ..
      "/targetfriend [mod:shift]",
  },
}

-- These macros are used only when mouselooking.
local mouselookMacros = {
  --[==[
  R = { text = [[
/use [form:1]Frenzied Regeneration
/use [@player,nomod:shift]Rejuvenation;[help,nodead]Rejuvenation;[help]Rebirth;[@party1,exists,nodead]Rejuvenation;[@party1,exists]Rebirth
  ]]},
  --]==]
}
-- < / MACROS > ------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local handlerFrame = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")

-- http://www.wowinterface.com/forums/showthread.php?p=267998
handlerFrame:SetScript("OnEvent", function(self, event, ...)
  return self[event] and self[event](self, ...)
end)

local function bind()
  for _, macro in _G.ipairs(macros) do
    _G.assert(macro.key)
    --if not macro.specs or macro.specs[specID] then
      if _G.type(macro.bind) == "function" then
        macro:bind()
      elseif macro.button then
        _G.SetBindingClick(macro.key, macro.button:GetName(), "LeftButton")
      elseif not macro.text then
        _G.SetBinding(macro.key, "CLICK NinjaKittyKeyBindsDummyButton")
      end
    --end
  end

  _G.SetBindingClick("BUTTON4", "NinjaKittyKeyBindsBUTTON4Button")
  _G.SetBindingClick("A", "NinjaKittyKeyBindsAButton")
  _G.SetBindingClick("D", "NinjaKittyKeyBindsDButton")
  --_G.SetBindingClick("Z", "NinjaKittyKeyBindsZButton")
  _G.SetBindingClick("C", "NinjaKittyKeyBindsCButton")
  --_G.SetBindingClick("V", "NinjaKittyKeyBindsVButton")
  --_G.SetBindingClick("K", "NinjaKittyKeyBindsKButton")
  _G.SetBinding("BUTTON1", "CAMERAORSELECTORMOVE")
  _G.SetBinding("BUTTON2", "INTERACTMOUSEOVER")
  --_G.SetBinding("F", "INTERACTMOUSEOVER")

  _G.SaveBindings(_G.GetCurrentBindingSet())
  NinjaKittyKeyBinds:Print("Commands bound and saved as " .. (_G.GetCurrentBindingSet() == 1 and
    "account" or "character specific") .. " binding set.")
end

function handlerFrame:ADDON_LOADED()
  self:UnregisterEvent("ADDON_LOADED")

  do
    -- TODO: make it work for pet battles?
    local overrideBarStateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

    --[[
    for _, v in ipairs({"A", "S", "D", "F", "G", "H"}) do
      overrideBarStateHandler:SetFrameRef(v .. "Button", _G["NinjaKittyKeyBinds" .. v .. "Button"])
    end
    ]]

    -- We don't use the first action bar as the possess bar because skills are put on it automatically while leveling.
    overrideBarStateHandler:SetAttribute("_onstate-overridebar", [[
      if newstate == "overridebar" then
        for i, key in ipairs(table.new("A", "S", "D", "F", "G", "H")) do
          self:SetBindingClick(false, key, "BT4Button" .. (12 + i))
          --self:SetBindingClick(false, key, "OverrideActionBarButton" .. (12 + i))
          --self:GetFrameRef(key .. "Button"):SetAttribute("macrotext", "/click BT4Button" .. (12 + i))
        end
        self:SetBindingClick(false, "ESCAPE", "BT4Button85")
      elseif newstate == "nooverridebar" then
        self:ClearBindings()
      end
    ]])

    _G.RegisterStateDriver(overrideBarStateHandler, "overridebar",
      "[overridebar][vehicleui][possessbar][bonusbar:5]overridebar;nooverridebar")

    --[=[
    overrideBarStateHandler:SetAttribute("_onstate-petbattle", [[
      print(newstate)
      if newstate == "petbattle" then
        for i, key in ipairs(table.new("A", "S", "D", "F", "G", "H")) do
          self:SetBindingClick(false, key, PetBattleFrame.BottomFrame.abilityButtons[i])
        end
      elseif newstate == "nopetbattle" then
        self:ClearBindings()
      end
    ]])

    _G.RegisterStateDriver(overrideBarStateHandler, "petbattle",
      "[petbattle]petbattle;nopetbattle")
    ]=]
  end

  NinjaKittyKeyBinds:RegisterChatCommand("nkkb", function(args, ...)
    if not _G.InCombatLockdown() and args == "bind" then
      bind()
    end
  end)

  self.ADDON_LOADED = nil
end

function handlerFrame:PLAYER_LOGIN()
  local specID, specName = _G.GetSpecializationInfo(_G.GetSpecialization() or 2)

  for _, macro in _G.ipairs(macros) do
    _G.assert(macro.key)
    if not macro.specs or macro.specs[specID] then
      if macro.text then
        macro.button = CreateFrame("Button", "NinjaKittyKeyBinds" .. macro.key .. "Button", UIParent,
                                   "SecureActionButtonTemplate")
        macro.button:SetAttribute("*type1", "macro")
        macro.button:SetAttribute("*macrotext1", macro.text)
      elseif macro.init and _G.type(macro.init) == "function" then
        macro.button = CreateFrame("Button", "NinjaKittyKeyBinds" .. macro.key .. "Button", UIParent,
                                   "SecureActionButtonTemplate")
        macro:init()
      end
    end
  end

  --[[
  for _, macro in _G.ipairs(mouselookMacros) do
    _G.assert(macro.key)
    if macro.text then
      if not macro.specs or macro.specs[specID] then
        macro.button = macro.button or CreateFrame("Button", "NinjaKittyKeyBinds" .. macro.key .. "Button", UIParent,
                                                   "SecureActionButtonTemplate")
        macro.button:SetAttribute("*type2", "macro")
        macro.button:SetAttribute("*macrotext2", macro["text"])
      end
    end
  end
  --]]

  for _, macros in _G.ipairs({macros, mouselookMacros}) do
    for _, macro in _G.ipairs(macros) do
      if _G.type(macro.text)  == "string" and macro.button then
        -- By default, a button only receives the left mouse button's "up" action.
        macro.button:RegisterForClicks("AnyDown")
      end
    end
  end

  -- Canceling form and using Wild Charge with just one use of the macro doesn't work.

  for key, macro in _G.pairs(mouselookMacros) do
    _G.SetMouselookOverrideBinding(macro.key, "CLICK " .. macro["button"]:GetName() .. ":RightButton")
  end

  do --[[ BUTTON4 Action Button --]]
    local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsBUTTON4Button", UIParent,
                                     "SecureActionButtonTemplate")
    actionButton:SetAttribute("type", "macro")

    local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

    --[[
    The macro for swapping target and focus (given both exists) would normally be:

    /tar focus
    /targetlasttarget
    /focus
    /targetlasttarget

    After the first two lines the target is unchanged and the focus is also the last target. Now we
    can simply focus the target and target the last target (which is the previous focus).

    However, this macro won't result in the expected behaviour if target and focus refer to the same
    unit: "/tar focus" will have no effect (not even that of changing the last target) and
    "/targetlasttarget" will actually target the last target. Thus, next it will focus the last
    target and then restore the target.

    The longer version used below will first clear the last target. Targeting the focus still does
    nothing, targeting the last target will clear the target, "/focus [@target,exists]" will do
    nothing and the last "/targetlasttarget" will restore the target.
    --]]
    local onState = [=[
      local macroText = ""
      if UnitExists("target") then
        if UnitExists("focus") then
          macroText =
            "/cleartarget            \n" ..
            "/targetlasttarget       \n" ..
            "/tar focus              \n" ..
            "/targetlasttarget       \n" ..
            "/focus [@target,exists] \n" ..
            "/targetlasttarget"
          --self:SetBinding(false, "MOUSEWHEELUP", "INTERACTMOUSEOVER")
          --self:ClearBinding("F")
        else
          macroText =
            "/focus" .. '\n' ..
            "/cleartarget"
        end
      else
        if UnitExists("focus") then
          macroText =
            "/tar focus" .. '\n' ..
            "/clearfocus"
        else
          macrotext = ""
        end
      end
      self:GetFrameRef("actionButton"):SetAttribute("macrotext", macroText)
    ]=]

    stateHandler:SetFrameRef("actionButton", actionButton)

    -- Arguments to _onstate-<stateid>: self, stateid, newstate.
    stateHandler:SetAttribute("_onstate-targetexists", onState)
    stateHandler:SetAttribute("_onstate-focusexists", onState)

    _G.RegisterStateDriver(stateHandler, "targetexists", "[exists]exists;noexists")
    _G.RegisterStateDriver(stateHandler, "focusexists", "[@focus,exists]exists;noexists")

    actionButton:RegisterForClicks("AnyDown")
  end --[[ BUTTON4 Action Button --]]
  -------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------
  do --[[ T Action Button --]]
    local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsTButton", UIParent,
                          "SecureActionButtonTemplate")
    actionButton:SetAttribute("*type1", "macro")
    actionButton:SetAttribute("*type2", "macro")

    -- Used when a target exists.
    actionButton:SetAttribute("*macrotext1", [[
/use [@focus,mod:shift][]Faerie Fire
    ]])

    -- Used when no target exists.
    actionButton:SetAttribute("*macrotext2", [[
/use [@focus,mod:shift]Faerie Fire
/stopmacro [mod:shift]
/targetenemyplayer
/stopmacro [noexists]
/use [exists]Faerie Fire
/cleartarget
    ]])

    local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

    stateHandler:SetFrameRef("actionButton", actionButton)

    -- Arguments to _onstate-<stateid>: self, stateid, newstate.
    stateHandler:SetAttribute("_onstate-targetexists", [[
      local actionButton = self:GetFrameRef("actionButton")
      if newstate == "exists" then
        self:SetBindingClick(false, "T", actionButton, "LeftButton")
      else
        self:SetBindingClick(false, "T", actionButton, "RightButton")
      end
    ]])

    _G.RegisterStateDriver(stateHandler, "targetexists", "[exists]exists;noexists")

    actionButton:RegisterForClicks("AnyDown")
  end --[[ T Action Button --]]
  -------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------
  --[=[
  do --[[ A Action Button --]]
    local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsAButton", UIParent,
                                     "SecureActionButtonTemplate")
    actionButton:SetAttribute("*type1", "macro")

    actionButton:SetAttribute("normalAndTarget", [[
/cancelform [form:5,flying]
/use !Prowl
/use [nostealth]Shadowmeld
/use [exists,harm]Pounce
    ]])

    actionButton:SetAttribute("normalNoTarget", [[
/cancelform [form:5,flying]
/use !Prowl
/use [nostealth]Shadowmeld
/stopmacro [nostealth]
/targetenemyplayer
/use [exists,harm]Pounce
/cleartarget
    ]])

    actionButton:SetAttribute("incarnationAndTarget", [[
/cancelform [form:5,flying]
/use [noform:3]!Prowl
/use [exists,harm]Pounce
    ]])

    actionButton:SetAttribute("incarnationNoTarget", [[
/cancelform [form:5,flying]
/use [noform:3]!Prowl
/targetenemyplayer
/use [exists,harm]Pounce
/cleartarget
    ]])

    _G.SecureHandlerWrapScript(actionButton, "OnClick", actionButton, [[
      local macrotext1 = ""
      -- Prowl had to be on action slot 73.
      local actionType, id, subType = GetActionInfo(73)
      if not id or id == 5215 or id ~= 102547 then -- Normal Prowl or we don't know.
        if UnitExists("target") then
          macrotext1 = self:GetAttribute("normalAndTarget")
        else
          macrotext1 = self:GetAttribute("normalNoTarget")
        end
      elseif id == 102547 then -- Version used while Incarnation is active.
        if UnitExists("target") then
          macrotext1 = self:GetAttribute("incarnationAndTarget")
        else
          macrotext1 = self:GetAttribute("incarnationNoTarget")
        end
      end
      self:SetAttribute("*macrotext1", macrotext1)
    ]])

    actionButton:RegisterForClicks("AnyDown")
  end --[[ A Action Button --]]
  --]=]
  --------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------
  do --[[ C Action Button --]]
    local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsCButton", UIParent,
                                     "SecureActionButtonTemplate")
    actionButton:SetAttribute("*type1", "macro")

    actionButton:SetAttribute("targetExists", [[
/use [@mouseover,help,nodead,noform,mod:shift][help,nodead,noform,mod:shift][@player,noform,mod:shift]Nourish
/use [nomod]Mighty Bash
/use [nomod]Disorienting Roar
/use [nomod]Ursol's Vortex
/use [mod:shift]Maim
    ]])

    actionButton:SetAttribute("noTarget", [[
/use [@mouseover,help,nodead,noform,mod:shift][help,nodead,noform,mod:shift][@player,noform,mod:shift]Nourish
/use [nomod]Disorienting Roar
/use [nomod]Ursol's Vortex
/targetenemyplayer [nomod]
/use [exists,nomod]Mighty Bash
/cleartarget [nomod]
    ]])

    _G.SecureHandlerWrapScript(actionButton, "OnClick", actionButton, [[
      local macrotext1 = ""
      if UnitExists("target") then
        macrotext1 = self:GetAttribute("targetExists")
      else
        macrotext1 = self:GetAttribute("noTarget")
      end
      self:SetAttribute("*macrotext1", macrotext1)
    ]])

    actionButton:RegisterForClicks("AnyDown")
  end --[[ C Action Button --]]
  --------------------------------------------------------------------------------------------------

  if specID == 103 then -- Feral.

    ---- < UNIQUE BINDINGS > -------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------

    --[===[
    -------------------------------------------------------------------------------------------------
    do --[[ A Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsAButton", UIParent,
                            "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type2", "macro")

      -- Used when a target exists.
      actionButton:SetAttribute("*macrotext1", [[
/cancelform [form:5,flying]
--/use [form:3]Pounce
/use !Prowl
/use [nostealth]Shadowmeld
      ]])

      -- Used when no target exists.
      actionButton:SetAttribute("*macrotext2", [[
/cancelform [form:5,flying]
/use !Prowl
/use [nostealth]Shadowmeld
--/stopmacro [nostealth]
--/targetenemyplayer
--/use [exists]Pounce
--/cleartarget
      ]])

      local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

      stateHandler:SetFrameRef("actionButton", actionButton)

      -- Arguments to _onstate-<stateid>: self, stateid, newstate.
      stateHandler:SetAttribute("_onstate-targetexists", [[
        local actionButton = self:GetFrameRef("actionButton")
        if newstate == "exists" then
          self:SetBindingClick(false, "A", actionButton, "LeftButton")
        else
          self:SetBindingClick(false, "A", actionButton, "RightButton")
        end
      ]])

      -- When logging in, "_onstate-targetexists" will also be called; newstate will be noexists.
      _G.RegisterStateDriver(stateHandler, "targetexists", "[exists]exists;noexists")

      actionButton:RegisterForClicks("AnyDown")
    end --[[ A Action Button --]]
    -------------------------------------------------------------------------------------------------
    --]===]

    -------------------------------------------------------------------------------------------------
    --[=[
    do --[[ D Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsDButton", UIParent,
                                       "SecureActionButtonTemplate")
      actionButton:SetAttribute("alt-type1", "macro")
      actionButton:SetAttribute("alt-type5", "macro")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type5", "macro")

      actionButton:SetAttribute("downbutton", "Button5")

      -- ALT-D is "/focus arena2" so this isn't used.
      actionButton:SetAttribute("alt-macrotext5", [[
/stopcasting
/cleartarget [form:1/3]
/targetenemy [form:1/3]
/use [exists,form:1/3]Skull Bash
/use [noform:1/3]Cat Form
      ]])

      actionButton:SetAttribute("alt-macrotext1", [[
/stopcasting
/cleartarget [form:1/3]
/targetenemy [form:1/3]
/use [exists,form:1/3]Skull Bash
      ]])

      -- Used when a target exists.
      actionButton:SetAttribute("withTargetDown", [[
/stopcasting
/use [noform:1/3]Cat Form;[nomod:shift][@focus,mod:shift]Skull Bash
      ]])

      -- Used when no target exists.
      actionButton:SetAttribute("elseDown", [[
/stopcasting
/targetenemyplayer [form:1/3]
/use [exists,form:1/3,nomod:shift][@focus,form:1/3,mod:shift]Skull Bash
/cleartarget [form:1/3]
/use [noform:1/3]Cat Form
      ]])

      -- Used when the key is released.
      actionButton:SetAttribute("withTargetUp", [[
/stopcasting
/use [nomod:shift][@focus,mod:shift]Skull Bash
      ]])

      actionButton:SetAttribute("elseUp", [[
/stopcasting
/targetenemyplayer [form:1/3]
/use [exists,form:1/3,nomod:shift][@focus,form:1/3,mod:shift]Skull Bash
/cleartarget [form:1/3]
      ]])

      _G.SecureHandlerWrapScript(actionButton, "OnClick", actionButton, [[
        local macrotext1, macrotext5 = "", ""
        --print(GetMouseButtonClicked())
        if UnitExists("target") then
          macrotext5 = self:GetAttribute("withTargetDown")
          macrotext1 = self:GetAttribute("withTargetUp")
        else
          macrotext5 = self:GetAttribute("elseDown")
          macrotext1 = self:GetAttribute("elseUp")
        end
        self:SetAttribute("*macrotext5", macrotext5)
        self:SetAttribute("*macrotext1", macrotext1)
      ]])

      actionButton:RegisterForClicks("AnyDown", "AnyUp")
    end --[[ D Action Button --]]
    ]=]
    --------------------------------------------------------------------------------------------------

    -------------------------------------------------------------------------------------------------
    --[=[
    do --[[ F Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsFButton", UIParent,
                            "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type2", "macro")
      actionButton:SetAttribute("*type3", "macro")
      actionButton:SetAttribute("*type4", "macro")

      -- Used when a target exists and the player is stealthed.
      actionButton:SetAttribute("*macrotext1", [[
/stopmacro [noexists][nostealth]
/use [@mouseover,exists]Mangle
/stopmacro [@mouseover,exists]
/use [form:1]Mangle;[noform,mod:shift]Wrath;[noform]Moonfire;[mod:shift]Ravage;Shred
      ]])

      -- Used when a target exists and the player isn't stealthed.
      actionButton:SetAttribute("*macrotext2", [[
/stopmacro [noexists][stealth]
/use [@mouseover,exists]Mangle
/stopmacro [@mouseover,exists]
/use [form:1]Mangle;[noform,mod:shift]Wrath;[noform]Moonfire;[mod:shift]Ravage;Shred
      ]])

      -- Used when no target exists and the player is stealthed. Since we are searching for a stealthed enemy and want
      -- to get the first hit, using Shred or even Ravage (no bang) is never a good idea as we can't depend on its
      -- positional requirement.
      actionButton:SetAttribute("*macrotext3", [[
/stopmacro [exists][nostealth]
/use [@mouseover,exists]Mangle
/stopmacro [@mouseover,exists]
/targetenemyplayer
/stopmacro [noexists]
/use [form:1]Mangle;[noform]Moonfire;[mod:shift]Ravage;Shred
/cleartarget
      ]])

      -- Used when no target exists and the player isn't stealthed.
      actionButton:SetAttribute("*macrotext4", [[
/stopmacro [exists][stealth]
/use [@mouseover,exists]Mangle
/stopmacro [@mouseover,exists]
/targetenemyplayer
/stopmacro [noexists]
/use [form:1]Mangle;[noform]Moonfire;[mod:shift]Ravage;Shred
/cleartarget
      ]])

      local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

      stateHandler:SetFrameRef("actionButton", actionButton)

      -- Arguments to _onstate-<stateid>: self, stateid, newstate.
      stateHandler:SetAttribute("_onstate-targetorstealth", [[
        local actionButton = self:GetFrameRef("actionButton")
        if newstate == "existsandstealth" then
          self:SetBindingClick(false, "F", actionButton, "LeftButton")
        elseif newstate == "existsandnostealth" then
          self:SetBindingClick(false, "F", actionButton, "RightButton")
        elseif newstate == "noexistsandstealth" then
          self:SetBindingClick(false, "F", actionButton, "MiddleButton")
        elseif newstate == "noexistsandnostealth" then
          self:SetBindingClick(false, "F", actionButton, "Button4")
        end
      ]])

      _G.RegisterStateDriver(stateHandler, "targetorstealth",
        "[exists,stealth]existsandstealth;[exists]existsandnostealth;" ..
        "[stealth]noexistsandstealth;noexistsandnostealth")

      actionButton:RegisterForClicks("AnyDown")
    end --[[ F Action Button --]]
    ]=]
    --------------------------------------------------------------------------------------------------

    -------------------------------------------------------------------------------------------------
    --[=[
    do --[[ Z Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsZButton", UIParent,
                                       "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")

      actionButton:SetAttribute("normalAndTarget", [[
/use [form:1]Maul;Mangle
      ]])

      actionButton:SetAttribute("normalNoTarget", [[
/targetenemyplayer
/use [form:1,exists]Maul;[exists]Mangle
/cleartarget
      ]])

      actionButton:SetAttribute("incarnationAndTarget", [[
/use !Prowl
      ]])

      actionButton:SetAttribute("incarnationNoTarget", [[
/use !Prowl
      ]])

      _G.SecureHandlerWrapScript(actionButton, "OnClick", actionButton, [[
        local macrotext1 = ""
        -- Prowl had to be on action slot 73.
        local actionType, id, subType = GetActionInfo(73)
        if not id or id == 5215 or id ~= 102547 then -- Normal Prowl or we don't know.
          if UnitExists("target") then
            macrotext1 = self:GetAttribute("normalAndTarget")
          else
            macrotext1 = self:GetAttribute("normalNoTarget")
          end
        elseif id == 102547 then -- Version used while Incarnation is active.
          if UnitExists("target") then
            macrotext1 = self:GetAttribute("incarnationAndTarget")
          else
            macrotext1 = self:GetAttribute("incarnationNoTarget")
          end
        end
        self:SetAttribute("*macrotext1", macrotext1)
      ]])

      actionButton:RegisterForClicks("AnyDown")
    end --[[ Z Action Button --]]
    ]=]
    --------------------------------------------------------------------------------------------------

    -------------------------------------------------------------------------------------------------
    --[=[
    do --[[ V Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsVButton", UIParent,
                            "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type2", "macro")

      -- Used when a target exists.
      actionButton:SetAttribute("*macrotext1", [[
/stopcasting
/use [nomod:shift]Typhoon
/use [exists,mod:shift,form:1]Lacerate;[exists,mod:shift,form:3]Rake
      ]])

      -- Used when no target exists.
      actionButton:SetAttribute("*macrotext2", [[
/stopcasting
/use [nomod:shift]Typhoon
/targetenemyplayer [mod:shift,form:1/3]
/use [exists,mod:shift,form:1]Lacerate;[exists,mod:shift,form:3]Rake
/cleartarget [mod:shift]
      ]])

      local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

      stateHandler:SetFrameRef("actionButton", actionButton)

      -- Arguments to _onstate-<stateid>: self, stateid, newstate.
      stateHandler:SetAttribute("_onstate-targetexists", [[
        local actionButton = self:GetFrameRef("actionButton")
        if newstate == "exists" then
          self:SetBindingClick(false, "V", actionButton, "LeftButton")
        else
          self:SetBindingClick(false, "V", actionButton, "RightButton")
        end
      ]])

      _G.RegisterStateDriver(stateHandler, "targetexists", "[exists]exists;noexists")

      actionButton:RegisterForClicks("AnyDown")
    end --[[ V Action Button --]]
    ]=]
    ------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------
    --[==[
    do --[[ K Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsKButton", UIParent,
                                       "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type2", "macro")

      actionButton:SetAttribute("targetMouseover", "/tar mouseover")

      actionButton:SetScript("PreClick", function(self, button, down)
        if down then
          _G.MouselookStop()
        else
          -- _G.MouselookStart()
        end
        --securecall(MouselookStop())
      end)

      _G.SecureHandlerWrapScript(actionButton, "OnClick", actionButton, [[
        local macrotext1, macrotext2 = "", ""
        macrotext1 = self:GetAttribute("targetMouseover")
        macrotext2 = self:GetAttribute("targetMouseover")
        self:SetAttribute("*macrotext1", macrotext1)
        self:SetAttribute("*macrotext2", macrotext2)
      ]])

      actionButton:RegisterForClicks("AnyDown", "AnyUp")
    end --[[ K Action Button --]]
    --]==]
    ------------------------------------------------------------------------------------------------

  elseif specID == 105 then -- Resto.

    ------------------------------------------------------------------------------------------------
    --[=[
    do --[[ V Action Button --]]
      local actionButton = CreateFrame("Button", "NinjaKittyKeyBindsVButton", UIParent,
                            "SecureActionButtonTemplate")
      actionButton:SetAttribute("*type1", "macro")
      actionButton:SetAttribute("*type2", "macro")

      -- Used when a target exists.
      actionButton:SetAttribute("*macrotext1",
        "/stopcasting" .. '\n' ..
        "/use [nomod:shift]Typhoon;[noform]Genesis;[exists,mod:shift,form:1]Lacerate;" ..
          "[exists,mod:shift,form:3]Rake"
      )

      -- Used when no target exists.
      actionButton:SetAttribute("*macrotext2",
        "/stopcasting" .. '\n' ..
        "/use [nomod:shift]Typhoon;[@player,noform]Genesis" .. '\n' ..
        "/targetenemyplayer [mod:shift,form:1/3]" .. '\n' ..
        "/use [exists,mod:shift,form:1]Lacerate;[exists,mod:shift,form:3]Rake" .. '\n' ..
        "/cleartarget [mod:shift]"
      )

      local stateHandler = CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

      stateHandler:SetFrameRef("actionButton", actionButton)

      -- Arguments to _onstate-<stateid>: self, stateid, newstate.
      stateHandler:SetAttribute("_onstate-targetexists", [[
        local actionButton = self:GetFrameRef("actionButton")
        if newstate == "exists" then
          self:SetBindingClick(false, "V", actionButton, "LeftButton")
        else
          self:SetBindingClick(false, "V", actionButton, "RightButton")
        end
      ]])

      _G.RegisterStateDriver(stateHandler, "targetexists", "[exists]exists;noexists")

      actionButton:RegisterForClicks("AnyDown")
    end --[[ V Action Button --]]
    ]=]
    ------------------------------------------------------------------------------------------------
    self:Execute([[

    ]])
  end
  ---- < / UNIQUE BINDINGS > -----------------------------------------------------------------------
end

function handlerFrame:PLAYER_ENTERING_WORLD()
end

function handlerFrame:SPELLS_CHANGED(...)
  NinjaKittyKeyBinds:Print("SPELLS_CHANGED", ...)
end

function handlerFrame:PLAYER_SPECIALIZATION_CHANGED(...)
  NinjaKittyKeyBinds:Print("PLAYER_SPECIALIZATION_CHANGED", ...)
end

handlerFrame:RegisterEvent("ADDON_LOADED")
handlerFrame:RegisterEvent("PLAYER_LOGIN")
handlerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
--handlerFrame:RegisterEvent("SPELLS_CHANGED")
--handlerFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

-- vim: tw=120 sw=2 et
