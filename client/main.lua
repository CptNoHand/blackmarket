QBCore = exports['qb-core']:GetCoreObject()

--- !(っ◕‿◕)っ Code!

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
                        RequestModel("g_m_m_chicold_01")
                        while not HasModelLoaded("g_m_m_chicold_01") do
                            Wait(10)
                        end
        
                        dealer = CreatePed(26, "g_m_m_chicold_01", loc["x"], loc["y"], loc["z"] - 1 , loc["h"], false, false)
                        SetEntityHeading(dealer, loc["h"])
                        SetBlockingOfNonTemporaryEvents(dealer, true)
                        TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
                        FreezeEntityPosition(dealer, true)
	                    SetEntityInvincible(dealer, true)
                    end
                else
                    Citizen.Wait(1500)
                end

                if dist <= 10 then
                    InRange = true
                    if dist <= 2 then
                        DrawText3Ds(loc["x"], loc["y"], loc["z"], '~g~E~w~')
                        if IsControlJustPressed(0, 38) then
                            if GetClockHours() >= Config.Open and GetClockHours() <= Config.Close then
                                TriggerEvent('market:client:Homepage')
                            else
                                QBCore.Functions.Notify('Come back another time.', 'error', 500)
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

--- !(っ◕‿◕)っ Buy Menu! (Only edit if you know what you are doing!)

RegisterNetEvent('market:client:buyItem')
AddEventHandler('market:client:buyItem', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("market:server:buyItems", 'trojan_usb')
    elseif args == 2 then 
        TriggerServerEvent("market:server:buyItems", 'security_card_01')
    elseif args == 3 then 
        TriggerServerEvent("market:server:buyItems", 'security_card_02')
    elseif args == 4 then 
        TriggerServerEvent("market:server:buyItems", 'drill')
    elseif args == 5 then 
        TriggerServerEvent("market:server:buyItems", 'heavyarmor')
    elseif args == 6 then 
        TriggerServerEvent("market:server:buyItems", 'screwdriverset')
    end
end)

RegisterNetEvent('market:client:buy1page')
AddEventHandler('market:client:buy1page', function()
    exports['qb-menu']:openMenu({
        {
            isHeader = true,
            header = "Blackmarket",
            txt = "Assistant"
        },
        {
            header = "Trojan USB: 2.5 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '1'
            }
        },
        {
            header = "Security Card A: 5 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '2'

            }
        },
        {
            header = "Security Card B: 5 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '3'

            }
        },
        {
            header = "Drill: 10 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '4'

            }
        },
        {
            header = "Armor: 15 bit",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '5'

            }
        },
        {
            header = "Screwdriver Kit: 10 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem",
                args = '6'

            }
        },
        {
            header = "Next Page",
			txt = "",
			params = {
                event = "market:client:buy2page",

            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

--- !(っ◕‿◕)っ Buy Menu! (2nd page"!)

RegisterNetEvent('market:client:buyItem2')
AddEventHandler('market:client:buyItem2', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("market:server:buyItems", 'pistol_suppressor')
    elseif args == 2 then 
        TriggerServerEvent("market:server:buyItems", 'pistol_extendedclip')
    elseif args == 3 then 
        TriggerServerEvent("market:server:buyItems", 'pistol_ammo')
    elseif args == 4 then 
        TriggerServerEvent("market:server:buyItems", 'thermite')
    elseif args == 5 then 
        TriggerServerEvent("market:server:buyItems", 'advancedlockpick')
    elseif args == 6 then 
        TriggerServerEvent("market:server:buyItems", 'WEAPON_PISTOL')
    end
end)


RegisterNetEvent('market:client:buy2page')
AddEventHandler('market:client:buy2page', function()
    exports['qb-menu']:openMenu({
        {
            isHeader = true,
            header = "Blackmarket",
            txt = "Assistant"
        },
        {
            header = "Pistol suppressor: 100 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '1'
            }
        },
        {
            header = "Pistol extendedclip: 100 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '2'

            }
        },
        {
            header = "Pistol ammo: 100 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '3'

            }
        },
        {
            header = "Thermite: 10 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '4'

            }
        },
        {
            header = "Advanced lockpick: 10 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '5'

            }
        },
        {
            header = "Pistol: 500 bits",
			txt = "Purchase",
			params = {
                event = "market:client:buyItem2",
                args = '6'

            }
        },
        {
            header = "Previous Page",
			txt = "",
			params = {
                event = "market:client:buy1page",
            }
        },
        {
            header = "Home Page",
			txt = "Back to main menu",
			params = {
                event = "market:client:Homepage",
            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

--- !(っ◕‿◕)っ Home Menu! (Only edit if you know what you are doing!)

RegisterNetEvent('market:client:Homepage')
AddEventHandler('market:client:Homepage', function()
    exports['qb-menu']:openMenu({
        {
            isHeader = true,
            header = "Blackmarket",
            txt = "Assistant"
        },
        {
            header = "Buy Page",
			txt = "Purchase Here",
			params = {
                event = "market:client:buy1page",
            }
        },
        {
            header = "Sell Page",
			txt = "Sell Items Here",
			params = {
                event = "market:client:SellPage",

            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

--- !(っ◕‿◕)っ Sell Menu! (Only edit if you know what you are doing!)

RegisterNetEvent('market:client:SellPage')
AddEventHandler('market:client:SellPage', function()
    exports['qb-menu']:openMenu({
        {
            isHeader = true,
            header = "Blackmarket",
            txt = "Assistant"
        },
        {
            header = "Get Item List",
			txt = "Items to collect",
			params = {
                event = "market:client:ItemList",
            }
        },
        {
            header = "Sell",
			txt = "Sell list items",
			params = {
                event = "market:client:sellItems",

            }
        },
        {
            header = "Home Page",
			txt = "Back to main menu",
			params = {
                event = "market:client:Homepage",

            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('market:client:sellItems')
AddEventHandler('market:client:sellItems', function()
    TriggerServerEvent('market:server:sellItems')
end)

--- !(っ◕‿◕)っ Item list email, Will reconfig for a item list within config.lua 
RegisterNetEvent('market:client:ItemList')
AddEventHandler('market:client:ItemList', function()
    Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = "The Assistant",
	subject = "Items",
	message = "So you are intrested in making some money? Alright... Get me: Secruity cards and Trojan!!"
	})
	Citizen.Wait(3000)
end)
