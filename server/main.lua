local QBCore = exports['qb-core']:GetCoreObject()

--- Buying Items!

RegisterNetEvent('market:server:BuyItems', function(products)
    local src = source
    local data = Config.Products[products]
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyPlayer = tonumber(Player.PlayerData.money.crypto)
    if moneyPlayer > data.sell then
        Player.Functions.RemoveMoney('crypto', tonumber(data.sell), 'black-market')
        Player.Functions.AddItem(products, 1, false)
        TriggerClientEvent('QBCore:Notify', source, " You Spent " ..data.sell.. " Bits ", 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough Crypto!", 'error')
    end
end)

--- Selling Items

RegisterServerEvent('market:server:SellItems', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local price = 0

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for i = 1, #Player.PlayerData.items do
            if Player.PlayerData.items[i] ~= nil then
                if Config.SellableItems[Player.PlayerData.items[i].name] ~= nil then 
                    price = price + (Config.SellableItems[Player.PlayerData.items[i].name] * Player.PlayerData.items[i].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[i].name, Player.PlayerData.items[i].amount)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[i].name], "remove")
                    Player.Functions.AddMoney("crypto", price, "sold pawnable items")
                    TriggerClientEvent('QBCore:Notify', source, " You Got " ..price.. " ", 'success')
                end
            end
        end
    end
end)
