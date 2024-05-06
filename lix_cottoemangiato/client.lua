ESX = exports["es_extended"]:getSharedObject()

local prezzo = Config.Prezzo
local playerPed = PlayerPedId()

local options = {
    {
        icon = 'fa-solid fa-burger',
        label = 'Cotto e mangiato',
        onSelect = function(data)
            lib.registerContext({
                id = 'lix_mangiaebevi',
                title = 'Cotto e mangiato',
                options = {
                    {
                        title = 'Mangia e bevi',
                        icon = 'burger',
                        onSelect = function()
                                ESX.TriggerServerCallback('lix:PrendiSoldi', function(hasoldi)
                                    if hasoldi then
                                        FreezeEntityPosition(playerPed, true)
                                        lib.progressBar({
                                            duration = 5000,
                                            label = 'Mangiando e Bevendo...',
                                            useWhileDead = false,
                                            canCancel = true,
                                            disable = {
                                                car = true,
                                            },
                                            anim = { 
                                                dict = 'mp_player_inteat@burger',
                                                clip = 'mp_player_int_eat_burger'
                                            },
                                        })
                                        TriggerEvent('esx_status:set', 'hunger', 500000) 
                                        TriggerEvent('esx_status:set', 'thirst', 500000) 
                                        FreezeEntityPosition(playerPed, false)
                                        lib.notify({
                                            title = 'Notifica',
                                            description = 'Ti sei rigenerato con successo!',
                                            type = 'success'
                                        })
                                    end
                                end, prezzo)
                        end
                    }
                }
            })

            lib.showContext('lix_mangiaebevi')
        end,
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity)
        end
    }
}

Citizen.CreateThread(function()
    local model = 'a_m_m_fatlatin_01'
    lib.requestModel(model)

    for k, v in pairs(Config.CordinatePed) do
        npc = CreatePed(4, model, v.x, v.y, v.z, v.h, false, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        exports.ox_target:addLocalEntity(npc, options)
    end
end)
