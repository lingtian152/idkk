local WhiteList = game:GetService("DataStoreService"):GetDataStore("WhiteList")
local Function = script.functions
local cmd = require(Function.cmd) -- commands script
local commands = require(script.commands)

local Temple = script.Temlpe




game:GetService("Players").PlayerAdded:Connect(function(player)

    local function output(text, name)
        local result = os.date("%I:%M %p", os.time())
        
        local Clone = Temple:clone()
        Clone.text.Text = tostring(result).." - "..tostring(text)
        Clone.Name = tostring(name)
        Clone.Parent = player.PlayerGui.OutPut.Base.ScrollingFrame
        
    end

    local Success, id = pcall(function()
        return WhiteList:GetAsync(player.UserId)
    end)

    if player.UserId == tonumber(id) or player.UserId == tonumber(game.CreatorId) then
        local Out = script.OutPut
        local clone = Out:Clone()
        clone.Name = "OutPut"
        clone.Parent = player.PlayerGui
    end

    if player.UserId == tonumber(id) then
        player.Chatted:Connect(function(msg) -- commands message listen

            if msg:sub(1, tostring(commands["kick"]):len()):lower() == tostring(commands["kick"]:lower()) then
                local playertokick = msg:sub(tostring(commands["kick"]:len() + 2))

                if playertokick then
                    cmd:kick(playertokick)
                    output(playertokick.." Has kicked", "kick")
                end
            end

            if msg:sub(1, commands["ban"]:len()):lower() == tostring(commands["ban"]:lower()) then
                local banid = msg:sub(tostring(commands["ban"]):len() + 2)
                output(banid.." has banned", "ban")
                cmd:ban(banid)
            end

            if msg:sub(1, commands["unban"]:len()):lower() == tostring(commands["unban"]:lower() )then
                local unbanid = msg:sub(commands["unban"]:len() + 2)
                output(unbanid.." has unban", "unban")
                cmd:unban(tostring(unbanid))
            end

            if msg:sub(1, commands["shutdown"]:len()):lower() == tostring(commands["shutdown"]:lower()) then
                output("This game has shutdown", "shutdown")
                wait(1.25)
                cmd:shutdown()
            end
        end)

        if player.UserId == tonumber(game.CreatorId) then
            player.Chatted:Connect(function(msg)
                if msg:sub(1, commands["add"]:len()):lower() == tostring(commands["add"]:lower()) then
                    local name = msg:sub(commands["add"]:len() + 2)
                    output(name.." has add to admin", "add")
                    cmd:whitelist(name)
                end

                if msg:sub(1, commands["remove"]:len()):lower() == tostring(commands["remove"]:lower()) then
                    local name = msg:sub(commands["remove"]:len() + 2)
                    output(name.. " has removed admin", "remove")
                    cmd:remove(name)
                end

                if msg:sub(1, commands["help"]:len()):lower() == tostring(commands["help"]):lower() then
                    output([[
                    
                    Admin: 
                    ;ban {Player Name} - ban player
                    ;kick {Player Name} - kick player
                    ;unban {Player Name} - unban player
                    ;shutdown - shutdown game
                    
                    Owner:
                    ;add {Player Name} - add player to admin
                    ;remove {Player Name} - remove a player's Admin
                    ]], "help")
                end
            end)
        end
    end
end)
