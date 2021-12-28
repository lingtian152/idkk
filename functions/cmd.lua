local cmd = {}

local datastore = game:GetService("DataStoreService"):GetDataStore("banstr")
local whitelist = game:GetService("DataStoreService"):GetDataStore("WhiteList")

local Players = game:GetService("Players")
local Message = game:GetService("MessagingService")


function cmd:kick(player, name)
    if name then
        Message:PublishAsync("Kick", tostring(name))
        return true
    end
end

function cmd:ban(name)
    local playerban = Players:GetUserIdFromNameAsync(name)

    if playerban then
        Message:PublishAsync("ban", name)
        datastore:SetAsync(playerban, playerban)
        return true
    else
        print("No Found Player")
        return false
    end
end

function cmd:unban(name)
    local unban = Players:GetUserIdFromNameAsync(name)

    if unban then
        datastore:RemoveAsync(unban)
        return true
    else
        print("Not Find "..unban.." In bandata")
        return false
    end
end

function cmd:shutdown()
    Message:PublishAsync("ShutDown", "ShutDown")
end

function cmd:whitelist(name)
    local id = Players:GetUserIdFromNameAsync(name)


    if id then
        Message:PublishAsync("whitelist", id)
        whitelist:SetAsync(id, id)
        print(name.." has add to admin")
        return true
    else
        print("No Found "..name)
        return false
    end
end

function cmd:remove(name)
    local nameid = Players:GetUserIdFromNameAsync(name)

    local sucess, id = pcall(function()
        return whitelist:GetAsync(nameid)
    end)

    if sucess then
        if id then
            whitelist:RemoveAsync(nameid)
            Message:PublishAsync("remove", nameid)
            print(name.." has remove admin")
            return true
        else
            print("Not Found "..name.." admin")
            return false
        end
    end
end

return cmd
