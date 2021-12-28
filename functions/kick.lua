local Players = game:GetService("Players")
local ms = game:GetService("MessagingService")

Players.PlayerAdded:Connect(function(player)
    local connect = ms:SubscribeAsync("Kick", function(message)
        if player.Name == message.Data then
            print("Success")
            player:Kick("You has kicked from game")
        end
    end)

    Players.PlayerRemoving:Connect(function()
        connect:Disconnect()
    end)
end)
