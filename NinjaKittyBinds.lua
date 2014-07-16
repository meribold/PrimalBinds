NinjaKittyBinds = { _G = _G }
setfenv(1, NinjaKittyBinds)

-- Can we make a macro that targets our last target and works when a Hunter uses Play Dead and stuff? Maybe
--   /targetlasttarget [noexists]
-- or
--   /stopmacro [exists]
--   /targetlasttarget
--   /startattack [combat,nostealth]

-- Can't target totems: Healing Stream Totem, Windwalk Totem, Earthbind Totem, Earthgrab Totem, Mana Tide Totem,
-- Healing Tide Totem, Capacitor Totem, Spirit Link Totem, ...

-- I think "/use [@party1]Rejuvenation" while having a party1 but being far away causes Rejuvenation to wait for us
-- clicking a target. "/use [@party1,exists]Rejuvenation" is the same. "/use [@party1,help] Rejuvenation" doesn't do it.
-- This seems like a better fix than "/use 1".

local secureHeader = _G.CreateFrame("Frame", nil, _G.UIParent, "SecureHandlerBaseTemplate")

---- < MACROS > --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Used to have "/cancelaura [form:3]Incarnation: King of the Jungle".

local macros = {
  {
    key = "`",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("downbutton", "RightButton")
      self.button:SetAttribute("*macrotext1", "/use Stampeding Roar")
      self.button:SetAttribute("*macrotext2",
        "/cancelaura Dash\n" ..
        "/use Stampeding Roar"
      )
      self.button:RegisterForClicks("AnyDown", "AnyUp")
      --_G.SetMouselookOverrideBinding(self.key, "CLICK " .. self.button:GetName() .. ":MiddleButton")
    end,
  },
  { key = "SHIFT-`" },
  { key = "ALT-`" },
  { -- Used to "/cancelform [form:5,flying]" here, too.
    key = "1",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("downbutton", "RightButton")
      self.button:SetAttribute("*macrotext1", "/use Dash")
      self.button:SetAttribute("*macrotext2",
        "/cancelaura Stampeding Roar\n" ..
        "/use Dash"
      )
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
      "/cancelaura Prowl",
  },
  { key = "3", text = "/use Cyclone" },
  { key = "SHIFT-3", text = "/use [@focus]Cyclone" },
  { -- "/castsequence [@player] Mark of the Wild,Foo" seems to reset on death.
    key = "ALT-3", text =
      "/cancelaura Goblin Glider\n" ..
      "/castsequence [@player] Mark of the Wild,Foo\n" ..
      "/userandom [nomounted,flyable]Silver Covenant Hippogryph,Cenarion War Hippogryph\n" ..
      "/userandom [nomounted,noflyable]Silver Covenant Hippogryph,Cenarion War Hippogryph,Swift Moonsaber," ..
        "Fossilized Raptor,Winterspring Frostsaber\n" ..
      "/use 15\n" ..
      "/dismount",
  },
  {
    key = "4", text =
      "/use [@mouseover,help,dead]Rebirth;[@mouseover,help]Healing Touch;[help,dead]Rebirth;[help]Healing Touch;" ..
        "[@player]Healing Touch",
  },
  {
    key = "SHIFT-4",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [@" .. db.party1 .. ",help,dead]Rebirth;[@" .. db.party1 .. ",help]Healing Touch"
      )
    end,
  },
  --[=[
  { -- This would be nice, but we can't get the name of a targeted party or raid member from a restricted environment.
    key = "SHIFT-4",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        if not self:GetAttribute("party1") or self:GetAttribute("party1") ~= owner:GetAttribute("party1") then
          local party1 = owner:GetAttribute("party1")
          self:SetAttribute("party1", party1)
          local text = "/use [@" .. party1 .. ",help,dead]Rebirth;[@" .. party1 .. ",help]Healing Touch"
          self:SetAttribute("*macrotext1", text)
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  ]=]
  {
    key = "ALT-4",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [@" .. db.party2 .. ",help,dead]Rebirth;[@" .. db.party2 .. ",help]Healing Touch"
      )
    end,
  },
  {
    key = "5", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [@mouseover,help,dead]Revive;[@mouseover,help]Rejuvenation;[help,dead]Revive;[help]Rejuvenation;" ..
        "[@player]Rejuvenation",
  },
  {
    key = "SHIFT-5",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [@" .. db.party1 .. ",help,dead]Revive;[@" .. db.party1 .. ",help]Rejuvenation"
      )
    end,
  },
  {
    key = "ALT-5",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [@" .. db.party2 .. ",help,dead]Revive;[@" .. db.party2 .. ",help]Rejuvenation"
      )
    end,
  },
  {
    key = "6", text =
      "/use Renewal\n" ..
      "/use [@mouseover,help,nodead][help,nodead][@player]Cenarion Ward",
  },
  --[[
  {
    key = "SHIFT-6", text =
      "/use [@party1]Cenarion Ward\n" ..
      "/use [@party1]1",
  },]]
  {
    key = "SHIFT-6",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [@" .. db.party1 .. ",help]Cenarion Ward"
      )
    end,
  },
  {
    key = "ALT-6",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [@" .. db.party2 .. ",help]Cenarion Ward"
      )
    end,
  },
  {
    key = "TAB",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("downbutton", "LeftButton")
      self.button:SetAttribute("*macrotext1",
        "/cancelaura Prowl\n" .. -- When we want to Shadowmeld, we want to Shadowmeld! We don't want to be told that
        "/use Shadowmeld\n" ..   -- "a more powerful spell is already active".
        "/use !Prowl"
      )
      self.button:SetAttribute("*macrotext2",
        "/use !Prowl"
      )
      self.button:RegisterForClicks("AnyDown", "AnyUp")
    end,
    bind = function(self)
      _G.SetBindingClick(self.key, self.button:GetName(), "RightButton")
    end
  },
  { key = "SHIFT-TAB" },
  { key = "ALT-TAB" },
  { key = "Q", text =
    "/use [noform:5]13",
  },
  { key = "SHIFT-Q" },
  { key = "ALT-Q" },
  {
    key = "W", specs = { [103] = true },
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1",
        "/use Tiger's Fury\n" ..
        "/use [form:3]10\n" ..
        "/use [form:3]14\n" ..
        "/castsequence [form:3]reset=1 0,10\n" ..
        "/castsequence [form:3]reset=1 0,Berserk\n" ..
        "/castsequence [form:3]reset=1 0,Berserking"
      )
      self.button:SetAttribute("*macrotext2", -- Used when we have Incarnation.
        "/use [form:3]Nature's Vigil\n" ..
        "/use [form:3]Tiger's Fury\n" ..
        "/use [form:3]14\n" ..
        "/use [form:3]10\n" ..
        "/use [form:3]Berserk\n" ..
        "/use [form:3]Berserking"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        local spellId = select(2, GetActionInfo(owner:GetAttribute("prowlActionSlot")))
        if spellId == 5215 then
          return
        elseif spellId == 102547 then
          return "RightButton"
        else
          return false
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  {
    key = "SHIFT-W", specs = { [103] = true }, text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use Incarnation\n" ..
      "/use Nature's Vigil\n" ..
      "/castsequence [form:3]reset=1 0,Tiger's Fury\n" ..
      "/castsequence [form:3]reset=1 0,14\n" ..
      "/castsequence [form:3]reset=1 0,10\n" ..
      "/castsequence [form:3]reset=1 0,Berserk\n" ..
      "/castsequence [form:3]reset=1 0,Berserking",
  },
  {
    key = "ALT-W", text =
      "/castsequence reset=1 0,Tranquility\n" ..
      "/use Heart of the Wild",
  },
  {
    key = "E", text =
      "/stopcasting\n" ..
      "/use Typhoon",
  },
  {
    key = "SHIFT-E",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1",
        "/use [exists]Mangle"
      )
      self.button:SetAttribute("*macrotext2", -- Used when we have Incarnation.
        "/use [harm]Pounce" -- Pounce auto-acquires a target when without a hostile target.
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        local spellId = select(2, GetActionInfo(owner:GetAttribute("prowlActionSlot")))
        if spellId == 5215 then
          return
        elseif spellId == 102547 then
          return "RightButton"
        else
          return false
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "ALT-E", text = "/use [@mouseover,help,nodead][@player]Mark of the Wild", },
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
  {
    key = "ALT-R", text =
      "/use Conjured Mana Buns\n" ..
      "/use Conjured Mana Pudding\n" ..
      "/use Cobo Cola\n" ..
      "/use Golden Carp Consomme",
  },
  {
    key = "T",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when [harm].
        "/use Faerie Fire"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use Faerie Fire\n" ..
        "/cleartarget"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  {
    key = "SHIFT-T", text =
      "/use [@focus]Faerie Fire",
  },
  { key = "ALT-T", text = "/use !Travel Form", },
  {
    key = "Y", specs = { [102] = true, [103] = true, [104] = true }, text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [@mouseover,help,nodead][help,nodead][@player]Remove Corruption",
  },
  {
    key = "SHIFT-Y", specs = { [102] = true, [103] = true, [104] = true },
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [@" .. db.party1 .. ",help]Remove Corruption"
      )
    end,
  },
  {
    key = "ALT-Y", specs = { [102] = true, [103] = true, [104] = true },
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/use [form:1]Frenzied Regeneration\n" ..
        "/use [@" .. db.party2 .. ",help]Remove Corruption"
      )
    end,
  },
  {
    key = "ESCAPE", text =
      "/use [form:1]Frenzied Regeneration\n" ..
      "/use [form:1]!Bear Form;[form:3]!Cat Form;[swimming]!Aquatic Form;[form:5][flyable,nocombat,outdoors]" ..
        "!Swift Flight Form;[outdoors]!Travel Form;!Cat Form",
  },
  { key = "SHIFT-ESCAPE" },
  { key = "ALT-ESCAPE" },
  {
    key = "A", text =
      "/use [noform,swimming]Aquatic Form;[noform,flyable,nocombat,outdoors]Swift Flight Form;" ..
        "[noform,outdoors]!Travel Form\n" ..
      "/use [form:1]Frenzied Regeneration\n" ..
      "/cancelform [form]\n" ..
      "/dismount [mounted]\n" ..
      "/stopcasting",
  },
  { key = "SHIFT-A" },
  { key = "ALT-A" },
  --[[
  {
    key = "S", text =
      "/stopcasting\n" ..
      "/use Displacer Beast\n" ..
      "/use [form:2/4][@mouseover,help,noform][@mouseover,harm,form:1/3][help,noform][harm,form:1/3][@party1,noform]" ..
        "Wild Charge\n" ..
      "/use [@party1,noform]1",
  },
  ]]
  { -- Canceling form and using Wild Charge with just one click isn't possible (I think).
    key = "S",
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/stopcasting\n" ..
        "/use Displacer Beast\n" ..
        "/use [form:2/4][@mouseover,help,noform][@mouseover,harm,form:1/3][help,noform][harm,form:1/3][@" .. db.party1
          .. ",help,noform]Wild Charge"
      )
    end,
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
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
    update = function(self)
      self.button:SetAttribute("*macrotext1",
        "/stopcasting\n" ..
        "/use [@" .. db.party2 .. ",help,noform]Wild Charge\n" ..
        --"/use [@" .. db.party2 .. ",help,noform]1\n" ..
        "/use [@mouseover,harm,form:1/3][harm,form:1/3]Skull Bash"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/stopcasting\n" ..
        "/use [@" .. db.party2 .. ",help,noform]Wild Charge\n" ..
        --"/use [@" .. db.party2 .. ",help,noform]1\n" ..
        "/stopmacro [@" .. db.party2 .. ",help,noform]\n" ..
        "/use [@mouseover,harm,form:1/3]Skull Bash\n" ..
        "/stopmacro [@mouseover,harm,form:1/3]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use [form:1/3]Skull Bash\n" ..
        "/cleartarget"
      )
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
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
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
    key = "Z", specs = { [103] = true },
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
      self.button:SetAttribute("*macrotext3", -- Used when we have Incarnation.
        "/cancelform [form:5,flying]\n" ..
        "/use !Prowl"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        local spellId = select(2, GetActionInfo(owner:GetAttribute("prowlActionSlot")))
        if spellId == 5215 then
          if not UnitExists("target") or not PlayerCanAttack("target") then
            return "RightButton"
          end
        elseif spellId == 102547 then
          return "MiddleButton"
        else
          return false
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end
  },
  { key = "SHIFT-Z" },
  { key = "ALT-Z" },
  { key = "X", text = "/use Survival Instincts" },
  { key = "SHIFT-X", text = "/use Barkskin" },
  {
    key = "ALT-X", text =
      "/use [@mouseover,help,nodead][help,nodead][@player]Innervate",
  },
  {
    key = "C",
    init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when [harm].
        "/use Disorienting Roar\n" ..
        "/use Ursol's Vortex\n" ..
        "/use [@mouseover,harm][]Mighty Bash"
      )
      self.button:SetAttribute("*macrotext2", -- Used when [noexists][noharm].
        "/use Disorienting Roar\n" ..
        "/use Ursol's Vortex\n" ..
        "/use [@mouseover,harm]Mighty Bash\n" ..
        "/stopmacro [@mouseover,harm]\n" ..
        "/targetenemyplayer\n" ..
        "/stopmacro [noexists][noharm]\n" ..
        "/use Mighty Bash\n" ..
        "/cleartarget"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "SHIFT-C", text = "/use Maim" }, -- Maim doesn't seem to auto-acquire a target.
  { key = "ALT-C", text = "/use Force of Nature" },
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
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        if not UnitExists("target") or not PlayerCanAttack("target") then
          return "RightButton"
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "ALT-V", text = "/use [@focus]Force of Nature" },
  { key = "B", text = "/use Entangling Roots" },
  { key = "SHIFT-B", text = "/use [@focus]Entangling Roots" },
  { key = "ALT-B", text = "/use Moonfire" },
  {
    key = "N", text =
      --"/use [form:3,mod:shift]Swipe;[form:3]Thrash;[form:1]Growl" .. '\n' ..
      "/use [form:1/3,mod:shift]Swipe;[form:1/3]Thrash\n" ..
      "/startattack [harm,nodead,form:1/3]",
  },
  { key = "ALT-N" }, -- FREE!
  {
    key = "ALT-MOUSEWHEELUP", text =
      "/targetexact Psyfiend\n" ..
      "/startattack [exists,harm]\n" ..
      "/use [exists,harm]Wild Charge\n" ..
      "/use [exists,harm]Mangle",
  },
  {
    key = "ALT-MOUSEWHEELDOWN", text =
      "/targetexact Wild Mushroom\n" ..
      "/targetexact Psyfiend\n" ..
      "/startattack [exists,harm]\n" ..
      "/use [exists,harm]Skull Bash",
  },
  { --[[
    The macro for swapping target and focus (given both exists) would normally be:
      /tar focus
      /targetlasttarget
      /focus
      /targetlasttarget

    After the first two lines the target is unchanged and the focus is also the last target. Now we can simply focus the
    target and target the last target (which is the previous focus).

    However, this macro won't result in the expected behaviour if target and focus refer to the same unit: "/tar focus"
    will have no effect (not even that of changing the last target) and "/targetlasttarget" will actually target the
    last target. Thus, next it will focus the last target and then restore the target.

    The longer version used below will first clear the last target. Targeting the focus still does nothing, targeting
    the last target will clear the target, "/focus [@target,exists]" will do nothing and the last "/targetlasttarget"
    will restore the target.
    ]]
    key = "BUTTON4", init = function(self)
      self.button:SetAttribute("type", "macro")
      self.button:SetAttribute("*macrotext1", -- Used when UnitExists("target") and UnitExists("focus").
        "/cleartarget\n" ..
        "/targetlasttarget\n" ..
        "/tar focus\n" ..
        "/targetlasttarget\n" ..
        "/focus [@target,exists]\n" ..
        "/targetlasttarget"
      )
      self.button:SetAttribute("*macrotext2", -- Used when UnitExists("target") and not UnitExists("focus").
        "/focus\n" ..
        "/cleartarget"
      )
      self.button:SetAttribute("*macrotext3", -- Used when not UnitExists("target") and UnitExists("focus").
        "/tar focus\n" ..
        "/clearfocus"
      )
      _G.SecureHandlerWrapScript(self.button, "OnClick", secureHeader, [[
        local macroText = ""
        if UnitExists("target") then
          if UnitExists("focus") then
            -- ...
          else
            return "RightButton"
          end
        else
          if UnitExists("focus") then
            return "MiddleButton"
          else
            return false
          end
        end
      ]])
      self.button:RegisterForClicks("AnyDown")
    end,
  },
  { key = "SHIFT-BUTTON4", text = "/focus" },
  { key = "ALT-BUTTON4" }, -- FREE!
  { key = "BUTTON5", text = "/targetfriendplayer" },
  { key = "SHIFT-BUTTON5", text = "/targetfriend" },
  { key = "ALT-BUTTON5" }, -- FREE!
}
-- < / MACROS > --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local handlerFrame = _G.CreateFrame("Frame")

-- http://www.wowinterface.com/forums/showthread.php?p=267998
handlerFrame:SetScript("OnEvent", function(self, event, ...)
  return self[event] and self[event](self, ...)
end)

local function bind()
  -- TODO: start by unbinding a lot of things? GetBinding(index) only returns command names and keys bound to binding
  -- ID's (http://wowpedia.org/BindingID).

  for _, macro in _G.ipairs(macros) do
    _G.assert(macro.key)
    if _G.type(macro.bind) == "function" then
      macro:bind()
    elseif macro.button then
      _G.SetBindingClick(macro.key, macro.button:GetName(), "LeftButton")
    else--[[if not macro.button then]]
      _G.SetBinding(macro.key, "CLICK NinjaKittyBindsDummyButton")
    end
  end

  -- See http://wowprogramming.com/docs/api_types#binding for the first parameter, http://wowpedia.org/BindingID for the
  -- second.
  _G.SetBinding("PRINTSCREEN", "SCREENSHOT")
  _G.SetBinding("F10", "TOGGLEGAMEMENU")
  _G.SetBinding("U", "TOGGLEWORLDMAP")
  _G.SetBinding("I", "OPENALLBAGS")
  _G.SetBinding("O", "TOGGLESOCIAL")
  _G.SetBinding("-", "MASTERVOLUMEDOWN")
  _G.SetBinding("=", "MASTERVOLUMEUP")
  --_G.SetBinding("F", "INTERACTMOUSEOVER")
  _G.SetBinding("J", "TOGGLEAUTORUN")
  _G.SetBinding("ENTER", "OPENCHAT")
  _G.SetBinding("/", "OPENCHATSLASH")
  _G.SetBinding("SPACE", "MOVEFORWARD")
  _G.SetBinding("BUTTON1", "CAMERAORSELECTORMOVE")
  _G.SetBinding("BUTTON2", "INTERACTMOUSEOVER")
  _G.SetBinding("BUTTON3", "JUMP")
  _G.SetBinding("CTRL-MOUSEWHEELUP", "CAMERAZOOMIN")
  _G.SetBinding("CTRL-MOUSEWHEELDOWN", "CAMERAZOOMOUT")

  _G.SaveBindings(_G.GetCurrentBindingSet())

  _G.print("Commands bound and saved as " .. (_G.GetCurrentBindingSet() == 1 and "account" or "character specific") ..
    " binding set.")
end

-- http://wowpedia.org/AddOn_loading_process#Order_of_events_fired_during_loading
function handlerFrame:ADDON_LOADED()
  self:UnregisterEvent("ADDON_LOADED")

  _G.assert(not _G.InCombatLockdown())

  if not _G.NinjaKittyBindsDB then
    _G.NinjaKittyBindsDB = {}
  end

  db = _G.NinjaKittyBindsDB

  local databaseDefaults = {
    party1 = "party1",
    party2 = "party2",
  }

  for k, v in _G.pairs(databaseDefaults) do
    if not db[k] then db[k] = v end
  end

  --secureHeader:SetAttribute("party1", db.party1)
  --secureHeader:SetAttribute("party2", db.party2)

  do
    -- TODO: make it work for pet battles?
    local overrideBarStateHandler = _G.CreateFrame("Frame", nil, nil, "SecureHandlerStateTemplate")

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

  -- http://wowpedia.org/Creating_a_slash_command
  _G.SLASH_NINJAKITTYKEYBINDS1, SLASH_NINJAKITTYKEYBINDS2 = "/nkkb"
  _G.SlashCmdList.NINJAKITTYKEYBINDS = function(message, editBox)
    if not _G.InCombatLockdown() and message == "bind" then
      bind()
    end
  end

  self.ADDON_LOADED = nil
end

function _G.NinjaKittyBinds:update()
  _G.assert(not _G.InCombatLockdown())
  for _, macro in _G.ipairs(macros) do
    if macro.update and macro.button then
      macro:update()
    end
  end
end

-- http://wowpedia.org/AddOn_loading_process#Order_of_events_fired_during_loading
function handlerFrame:PLAYER_LOGIN()
  _G.assert(not _G.InCombatLockdown())

  do
    -- Find the first action slot that Prowl (could be 5215 or 102547) is placed in. We can use it to find if
    -- Incarnation is active or not. If we move Prowl we have to /reload; TODO: can we find the new action slot directly
    -- even if in combat?
    -- http://wowpedia.org/API_GetActionInfo
    -- http://wowprogramming.com/docs/api/GetActionInfo
    local actionType, id, subType
    if db.prowlActionSlot then
      actionType, id, subType = _G.GetActionInfo(db.prowlActionSlot)
    end
    if not actionType or actionType ~= "spell" or not id or (id ~= 5215 and id ~= 102547) then
      db.prowlActionSlot = nil
      for i = 1, 120 do
        local actionType, id, subType = _G.GetActionInfo(i)
        if actionType and actionType == "spell" and (id == 5215 or id == 102547) then
          db.prowlActionSlot = i
          break
        end
      end
    end
    secureHeader:SetAttribute("prowlActionSlot", db.prowlActionSlot)
  end

  local specID, specName = _G.GetSpecializationInfo(_G.GetSpecialization() or 2)

  for _, macro in _G.ipairs(macros) do
    _G.assert(macro.key)
    if not macro.specs or macro.specs[specID] then
      if macro.text or macro.init or macro.update then
        macro.button = _G.CreateFrame("Button", "NinjaKittyBinds" .. macro.key .. "Button", _G.UIParent,
          "SecureActionButtonTemplate")
      end
      if macro.init --[[and _G.type(macro.init) == "function"]] then
        macro:init()
      elseif macro.button then
        macro.button:SetAttribute("type", "macro")
        -- By default, a button only receives the left mouse button's "up" action.
        macro.button:RegisterForClicks("AnyDown")
      end
      if macro.text then
        macro.button:SetAttribute("*macrotext1", macro.text)
      end
    end
  end

  update()
end

function handlerFrame:PLAYER_ENTERING_WORLD()
  -- ...
end

function handlerFrame:SPELLS_CHANGED(...)
  _G.print("SPELLS_CHANGED", ...)
end

function handlerFrame:PLAYER_SPECIALIZATION_CHANGED(...)
  _G.print("PLAYER_SPECIALIZATION_CHANGED", ...)
end

handlerFrame:RegisterEvent("ADDON_LOADED")
handlerFrame:RegisterEvent("PLAYER_LOGIN")
--handlerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
--handlerFrame:RegisterEvent("SPELLS_CHANGED")
--handlerFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

-- vim: tw=120 sw=2 et