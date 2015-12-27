--[[
    Shine No Rookies - Server
]]
local Plugin = Plugin

Plugin.Version = "1.0"

Plugin.ConfigName = "RookiesOnly.json"
Plugin.DefaultConfig =
{
    Mode = 1, -- 1: Level 2: Playtime
    MaxPlaytime = 20,
    MaxLevel = 5,
    ShowInform = false,
    InformMessage = "This server is rookies only",
    AllowSpectating = true,
    BlockMessage = "This server is rookies only",
    Kick = true,
    Kicktime = 20,
    KickMessage = "You will be kicked in %s seconds",
    WaitMessage = "Please wait while we fetch your stats.",
    ShowSwitchAtBlock = false
}

Plugin.PrintName = "Rookies Only"
Plugin.DisconnectReason = "You are not a rookie anymore"

Plugin.Conflicts = {
	DisableUs = {
		"hiveteamrestriction",
		"norookies"
	}
}

function Plugin:Initialise()
    self.Enabled = true

    self:CheckForSteamTime()
    self:BuildBlockMessage()

    return true
end

function Plugin:CheckForSteamTime() --This plugin does not use steam times at all
end

function Plugin:BuildBlockMessage()
    self.BlockMessage = self.Config.BlockMessage
end

function Plugin:CheckValues( Playerdata, SteamId )
	if not self.Passed then self.Passed = {} end
	if self.Passed[SteamId] then return self.Passed[SteamId] end

    if self.Config.Mode == 1 then
        if self.Config.MaxLevel > 0 and Playerdata.level <= self.Config.MaxLevel then
            self.Passed[SteamId] = true
            return true
        end
    elseif self.Config.MaxPlaytime > 0 and Playerdata.playTime <= self.Config.MaxPlaytime * 3600 then
	    self.Passed[SteamId] = true
        return true
    end

	self.Passed[SteamId] = false
	return false
end
