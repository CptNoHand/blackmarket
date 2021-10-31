local QBCore = exports['qb-core']:GetCoreObject()

--- !(っ◕‿◕)っ Buy Items! (Only edit if you know what you are doing!)

RegisterNetEvent("market:server:buyItems")
AddEventHandler("market:server:buyItems", function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer > data.sell then
        Player.Functions.RemoveMoney("crypto", tonumber(data.sell), "black-market")
        if Player.Functions.GetItemByName(products) then
            TriggerClientEvent('QBCore:Notify', source, products.." has been brought!", "success")
        else
            Player.Functions.AddItem(products, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[products], "add", 1) 
            TriggerClientEvent('QBCore:Notify', source, " You Spent " ..data.sell.. " Bits  ", "success")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", "error")
    end
end)

--- !(っ◕‿◕)っ Selling Items! (Only edit if you know what you are doing!)

RegisterServerEvent("market:server:sellItems")
AddEventHandler("market:server:sellItems", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local price = 0

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for i = 1, #Player.PlayerData.items do
            if Player.PlayerData.items[i] ~= nil then
                if Config.SellableItems[Player.PlayerData.items[i].name] ~= nil then 
                    price = price + (Config.SellableItems[Player.PlayerData.items[i].name] * Player.PlayerData.items[i].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[i].name, Player.PlayerData.items[i].amount)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[i].name], "remove")
                end
            end
        end
        Player.Functions.AddMoney("crypto", price, "sold pawnable items")
        TriggerClientEvent('QBCore:Notify', src, "You have sold your items")
    end
end)
