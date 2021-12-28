game:GetService("MessagingService"):SubscribeAsync("ShutDown", function(message) -- shutdown game
    for _, players in pairs(game:GetService("Players"):GetPlayers()) do
        if message then
            players:Kick("This game has shutdown Please Join this game later")
        end
    end
end)
