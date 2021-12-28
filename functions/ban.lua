local datastore = game:GetService("DataStoreService"):GetDataStore("banstr") -- banned player datastore

game:GetService("Players").PlayerAdded:Connect(function(player) -- banned player
    local success, id = pcall(function()
        return datastore:GetAsync(player.UserId)
    end)

    if success then
        if player.UserId == id then
            player:Kick("You has banned from this game")
        end
    elseif not success then
        warn(not success)
    end
end)

game:GetService("Players").PlayerAdded:Connect(function(player)
    local connect = game:GetService("MessagingService"):SubscribeAsync("ban", function(message)
        if player.Name == message.Data then
            player:Kick("You has banned from game")
        end
    end)
    
    game:GetService("Players").PlayerRemoving:Connect(function()
        connect:Disconnect()
    end)
end)
