local whitelist = game:GetService("DataStoreService"):GetDataStore("WhiteList")

game:GetService("Players").PlayerAdded:Connect(function(player)
    local conenct1 = game:GetService("MessagingService"):SubscribeAsync("whitelist", function(message)
        if player.UserId == message.Data then
           player:Kick("You are admin now, Please rejoin")
        end
    end)
    
    local connect2 = game:GetService("MessagingService"):SubscribeAsync("remove", function(message)
        if player.UserId == message.Data then
            player:Kick("You not admin now! please rejoin")
        end
        end)
    
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        conenct1:Disconnect()
        connect2:Disconnect()
    end)
end)
