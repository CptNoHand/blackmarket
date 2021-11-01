QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            for _, loc in pairs(position) do
                local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
                if dist <= 500.0 then
                    if not DoesEntityExist(dealer) then
                        RequestModel('g_m_m_chicold_01')
                        while not HasModelLoaded('g_m_m_chicold_01') do
                            Wait(10)
                        end
                        dealer = CreatePed(26, 'g_m_m_chicold_01', loc["x"], loc["y"], loc["z"] - 1 , loc["h"], false, false)
                        SetEntityHeading(dealer, loc["h"])
                        SetBlockingOfNonTemporaryEvents(dealer, true)
                        TaskStartScenarioInPlace(dealer, 'WORLD_HUMAN_AA_SMOKE', 0, false)
                        FreezeEntityPosition(dealer, true)
	                    SetEntityInvincible(dealer, true)
                    end
                else
                    Citizen.Wait(1500)
                end
                if dist <= 10 then
                    InRange = true
                    if dist <= 2 then
                        DrawText3Ds(loc["x"], loc["y"], loc["z"], "~r~E")
                        if IsControlJustPressed(0, 38) then
                            if GetClockHours() >= Config.Open and GetClockHours() <= Config.Close then
                                TriggerEvent('market:client:HomeMenu')
                            else
                                QBCore.Functions.Notify("Come back another time.", 'error', 500)
                            end
                        end
                    end
                end
            end
        end
        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Home menu

RegisterNetEvent('market:client:HomeMenu')
AddEventHandler('market:client:HomeMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Assistant",
            isMenuHeader = true
        },
        {
            header = "Buy Menu",
			txt = "Purchase Here",
			params = {
                event = 'market:client:BuyMenu'
            }
        },
        {
            header = "Sell Menu",
			txt = "Sell Items Here",
			params = {
                event = 'market:client:SellMenu'

            }
        },
        {
            header = "Close menu",
			txt = "",
			params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

-- Buying menu

RegisterNetEvent('market:client:BuyMenu')
AddEventHandler('market:client:BuyMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Assistant",
            isMenuHeader = true
        },
        {
            header = "Trojan USB: 2.5 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '1'
            }
        },
        {
            header = "Security Card A: 5 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '2'

            }
        },
        {
            header = "Security Card B: 5 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '3'

            }
        },
        {
            header = "Armor: 15 bit",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '4'

            }
        },
        {
            header = "Pistol suppressor: 100 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '5'
            }
        },
        {
            header = "Pistol extendedclip: 100 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '6'

            }
        },
        {
            header = "Pistol ammo: 100 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '7'

            }
        },
        {
            header = "Pistol: 500 bits",
			txt = "Purchase",
			params = {
                event = 'market:client:BuyItems',
                args = '8'

            }
        },
        {
            header = "Close menu",
			txt = "",
			params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

-- Buying function

RegisterNetEvent('market:client:BuyItems')
AddEventHandler('market:client:BuyItems', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent('market:server:BuyItems', 'trojan_usb')
    elseif args == 2 then 
        TriggerServerEvent('market:server:BuyItems', 'security_card_01')
    elseif args == 3 then 
        TriggerServerEvent('market:server:BuyItems', 'security_card_02')
    elseif args == 4 then 
        TriggerServerEvent('market:server:BuyItems', 'heavyarmor')
    elseif args == 5 then 
        TriggerServerEvent('market:server:BuyItems', 'pistol_suppressor')
    elseif args == 6 then 
        TriggerServerEvent('market:server:BuyItems', 'pistol_extendedclip')
    elseif args == 7 then 
        TriggerServerEvent('market:server:BuyItems', 'pistol_ammo')
    elseif args == 8 then 
        TriggerServerEvent('market:server:BuyItems', 'WEAPON_PISTOL')
    end
end)

-- Sell menu

RegisterNetEvent('market:client:SellMenu')
AddEventHandler('market:client:SellMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Assistant",
            isMenuHeader = true        
        },
        {
            header = "Sell",
			txt = "Sell items",
			params = {
                event = 'market:client:SellItems'

            }
        },
        {
            header = "Close menu",
			txt = "",
			params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

-- Selling function

RegisterNetEvent("market:client:SellItems")
AddEventHandler("market:client:SellItems", function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    QBCore.Functions.Progressbar("sell_items", "Checking items of value", 3000, false, true, {}, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('market:server:SellItems')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled...", 'error')
    end) 
end)