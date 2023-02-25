if Config.NewESX then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end

local RNE = RegisterNetEvent
local AEH = AddEventHandler 
local TE = TriggerEvent 
local TSE = TriggerServerEvent 
local CT = CreateThread
local instruktor = {}
local tacno = false
local netacno = false
local greske = 0 
local speedprovera = false


--[[
    TO DO TASKS

    Interactiv Sounds 
    Draw3dText iznad glave u config u podesavanje oko toga.
    Scenario pisanja!


--]]

RegisterNetEvent('gg-autoskola:ucitajLicence')
AddEventHandler('gg-autoskola:ucitajLicence', function(licenses)
	Licenses = licenses
end)


CT(function()
    RequestModel(GetHashKey(Config.Instruktor))
    while not HasModelLoaded(GetHashKey(Config.Instruktor)) do
    Wait(1)
    end
    pedautoskola = CreatePed(4, Config.Instruktor, Config.Autoskola["ped"].kordinate, Config.Autoskola["ped"].heading, false, true)
    FreezeEntityPosition(pedautoskola, true) 
    SetEntityInvincible(pedautoskola, true)
    SetBlockingOfNonTemporaryEvents(pedautoskola, true)
    table.insert(instruktor, pedautoskola)
    exports.qtarget:AddBoxZone("autoskola", Config.Autoskola["ped"].kordinate, 0.85, 0.65, {
        name="autoskola",
        heading=11.0,
        debugPoly=Config.DebugZone,
        minZ=Config.Autoskola["ped"].kordinate.z -1,
        maxZ=Config.Autoskola["ped"].kordinate.z +2,
        }, {
            options = {
                {
                    action = function()
                        lib.registerContext({
                            id = 'instruktor',
                            title = Translation.EN["drivingschool"].label,
                            options = Config.Tests,
                        })
                        lib.showContext('instruktor')
                    end,
                    label = Translation.EN["instruktor"].label,
                },
            },
            distance = Config.Distanca
    })
    local blipara = AddBlipForCoord(Config.Autoskola["ped"].kordinate)
	
	SetBlipSprite (blipara, Config.Autoskola["ped"].id)
	SetBlipDisplay(blipara, 4)
	SetBlipScale  (blipara, Config.Autoskola["ped"].velicina)
	SetBlipColour (blipara, 3)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(Translation.EN["blip"].label)
	EndTextCommandSetBlipName(blipara)
end)




---pitanja

RNE("gg:pokreni_pitanja_b_1")
AEH("gg:pokreni_pitanja_b_1", function(data)
    ESX.TriggerServerCallback("gg:imal_za_B", function(imal)
        if imal then 
            local input = lib.inputDialog(Translation.EN["pitanje1"].label, {
                { type = 'select', label = Translation.EN["choose"].label, options = {
                { value = 'option1', label = Translation.EN["odgpt1"].label },
                { value = 'option2', label = Translation.EN["odgpt2"].label },
                { value = 'option3', label = Translation.EN["odgpt3"].label },
                }},
            })
            local selekcija = input[1]
            if selekcija == 'option1' then 
                greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
                TE("gg:pokreni_pitanja_b_2",data)
            elseif  selekcija == 'option2' then 
                Notify(Translation.EN["correctanswer"].label)
                TE("gg:pokreni_pitanja_b_2",data)
            elseif  selekcija == 'option3' then 
                greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
                TE("gg:pokreni_pitanja_b_2",data)
            end
        end
    end, data.price)
end)


RNE("gg:pokreni_pitanja_b_2")
AEH("gg:pokreni_pitanja_b_2", function(data)
    if greske >= Config.MaxAllowedMistakes then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
    local input = lib.inputDialog(Translation.EN["pitanje2"].label, {
        { type = 'select', label = Translation.EN["choose"].label, options = {
        { value = 'option1', label = Translation.EN["odgpt4"].label },
        { value = 'option2', label = Translation.EN["odgpt5"].label },
        { value = 'option3', label = Translation.EN["odgpt6"].label },
        }},
    })
    local selekcija = input[1]
        if selekcija == 'option1' then 
        Notify(Translation.EN["correctanswer"].label)
        TE("gg:pokreni_pitanja_b_3",data)
        elseif  selekcija == 'option2' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_3",data)
        elseif  selekcija == 'option3' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_3",data)
        end
    end
end)


RNE("gg:pokreni_pitanja_b_3")
AEH("gg:pokreni_pitanja_b_3", function(data)
    if greske >= 2 then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
    local input = lib.inputDialog(Translation.EN["pitanje3"].label, {
        { type = 'select', label = Translation.EN["choose"].label, options = {
        { value = 'option1', label = Translation.EN["odgpt7"].label },
        { value = 'option2', label = Translation.EN["odgpt8"].label },
        { value = 'option3', label = Translation.EN["odgpt9"].label },
        }},
    })
    local selekcija = input[1]
        if selekcija == 'option1' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_4",data)
        elseif  selekcija == 'option2' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_4",data)
        elseif  selekcija == 'option3' then 
            Notify(Translation.EN["correctanswer"].label)
            TE("gg:pokreni_pitanja_b_4",data)
        end
    end
end)

RNE("gg:pokreni_pitanja_b_4")
AEH("gg:pokreni_pitanja_b_4", function(data)
    if greske >= 2 then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
        local input = lib.inputDialog(Translation.EN["pitanje4"].label, {
            { type = 'select', label = Translation.EN["choose"].label, options = {
            { value = 'option1', label = Translation.EN["odgpt10"].label },
            { value = 'option2', label = Translation.EN["odgpt11"].label },
            { value = 'option3', label = Translation.EN["odgpt12"].label },
            { value = 'option4', label = Translation.EN["odgpt13"].label },
            }},
        })
        local selekcija = input[1]
        if selekcija == 'option1' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_5",data)
        elseif  selekcija == 'option2' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_5",data)
        elseif  selekcija == 'option3' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_5",data)
        elseif  selekcija == 'option4' then 
            Notify(Translation.EN["correctanswer"].label)
            TE("gg:pokreni_pitanja_b_5",data)
        end
    end
end)


RNE("gg:pokreni_pitanja_b_5")
AEH("gg:pokreni_pitanja_b_5", function(data)
    if greske >= 2 then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
        local input = lib.inputDialog(Translation.EN["pitanje5"].label, {
            { type = 'select', label = Translation.EN["choose"].label, options = {
            { value = 'option1', label = Translation.EN["odgpt14"].label },
            { value = 'option2', label = Translation.EN["odgpt15"].label },
            { value = 'option3', label = Translation.EN["odgpt16"].label },
            { value = 'option4', label = Translation.EN["odgpt17"].label },
            }},
        })
        local selekcija = input[1]
        if selekcija == 'option1' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_6",data)
        elseif  selekcija == 'option2' then 
            greske = greske + 1
                Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_6",data)
        elseif  selekcija == 'option3' then 
            Notify(Translation.EN["correctanswer"].label)
            TE("gg:pokreni_pitanja_b_6",data)
        elseif  selekcija == 'option4' then 
            greske = greske + 1
            Notify(Translation.EN["wronganswer"].label)
            TE("gg:pokreni_pitanja_b_6",data)
        end
    end
end)


RNE("gg:pokreni_pitanja_b_6")
AEH("gg:pokreni_pitanja_b_6", function(data)
    if greske >= 2 then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
        local input = lib.inputDialog(Translation.EN["pitanje6"].label, {
            { type = 'select', label = Translation.EN["choose"].label, options = {
            { value = 'option1', label = Translation.EN["odgpt18"].label },
            { value = 'option2', label = Translation.EN["odgpt19"].label },
            { value = 'option3', label = Translation.EN["odgpt20"].label },
            }},
        })
        local selekcija = input[1]
        if selekcija == 'option1' then 
            Notify(Translation.EN["correctanswer"].label)
            greske = 0
            stvorivozilo(data)
        elseif  selekcija == 'option2' then 
            greske = greske + 1
            Notify(Translation.EN["wronganswer"].label)
            stvorivozilo(data)
        elseif  selekcija == 'option3' then 
            greske = greske + 1
            Notify(Translation.EN["wronganswer"].label)
            stvorivozilo(data)
        end
    end
end)


function stvorivozilo(data)
    if greske >= 2 then
        Notify(Translation.EN["paliste"].label)
        greske = 0
    else 
        if ESX.Game.IsSpawnPointClear(Config.Autoskola["vozilo"].kordinate, 1.5) then 
            Notify(Translation.EN["vozilo"].label)
            ESX.Game.SpawnVehicle(data.vehicle, Config.Autoskola["vozilo"].kordinate, Config.Autoskola["vozilo"].heading, function(auto) 
            for i = 1, #instruktor do  
                SetPedIntoVehicle(instruktor[i], auto, -2)
                TaskStartScenarioInPlace(instruktor[i],'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)
            end   
        end) 
            HelpNotify(Translation.EN["prakticno"].label)
            TriggerEvent("gg:zapoceo_prakticni")     
        end
    end
end

RegisterCommand("autoskola", function()
    TriggerEvent("gg:pokreni_pitanja_b_6")
end)

local lokacija1 = false
local lokacija2 = true
local lokacija3 = true
local lokacija4 = true
local lokacija5 = true
local lokacija6 = true
local lokacija7 = true
local lokacija8 = true
local lokacija9 = true
local lokacija10 = true
local lokacija11 = true
local lokacija12 = true
local lokacija13 = true
local lokacija14 = true
local lokacija15 = true
local lokacija16 = true
---
RNE("gg:zapoceo_prakticni")
AEH("gg:zapoceo_prakticni", function()
    local coords = GetEntityCoords(PlayerPedId())
    local najblizevozilo = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    local stanje = GetVehicleEngineHealth(najblizevozilo) /10
	local stanje2 = GetVehicleBodyHealth(najblizevozilo) /10
    local igrac = PlayerPedId()
        speedprovera = true 
        speedcheck()
    while true do
        Wait(0)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vozilo = GetVehiclePedIsIn(PlayerPedId(), false)
            if lokacija1 == false  then
                HelpNotify(Translation.EN["dalje"].label, 3000)
                DrawMarker(20, Config.Markeri["lokacija1"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija1"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["grad"].label, 3000)
                    Wait(4000)
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija1 = true
                    lokacija2 = false
                    SetNewWaypoint(Config.Markeri["lokacija2"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija2 == false then
            DrawMarker(20, Config.Markeri["lokacija2"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
            -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija2"].kordinata, 1.5) then
            if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija2"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true) 
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija2 = true
                    lokacija3 = false
                    SetNewWaypoint(Config.Markeri["lokacija3"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija3 == false  then
            DrawMarker(20, Config.Markeri["lokacija3"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
            -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija3"].kordinata, 1.5) then 
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija3"].kordinata) <= 2.0 then 
                FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija3 = true
                    lokacija4 = false
                    SetNewWaypoint(Config.Markeri["lokacija4"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija4 == false  then
            DrawMarker(20, Config.Markeri["lokacija4"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
            -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija4"].kordinata, 1.5) then 
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija4"].kordinata) <= 2.0 then 
                FreezeEntityPosition(vozilo, true)
                lib.progressCircle({
                    duration = Config.Cekanje,
                    label = Translation.EN["waiting"].label,
                    useWhileDead = false,
                    disable = {
                        move = true,
                        car = true,
                        combat = true,
                    },
                })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija4 = true
                    lokacija5 = false
                    SetNewWaypoint(Config.Markeri["lokacija5"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija5 == false  then
                DrawMarker(20, Config.Markeri["lokacija5"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija5"].kordinata, 1.5) then 
                    if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija5"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija5 = true
                    lokacija6 = false
                    SetNewWaypoint(Config.Markeri["lokacija6"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija6 == false  then
                DrawMarker(20, Config.Markeri["lokacija6"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija6"].kordinata, 1.5) then 
                    if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija6"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija6 = true
                    lokacija7 = false
                    SetNewWaypoint(Config.Markeri["lokacija7"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija7 == false  then
                DrawMarker(20, Config.Markeri["lokacija7"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                -- if IsAnyVehicleNearPoint(Config.Markeri["lokacija7"].kordinata, 1.5) then 
                    if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija7"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija7 = true
                    lokacija8 = false
                    SetNewWaypoint(Config.Markeri["lokacija8"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija8 == false  then
                DrawMarker(20, Config.Markeri["lokacija8"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija8"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija8 = true
                    lokacija9 = false
                    SetNewWaypoint(Config.Markeri["lokacija9"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija9 == false  then
                DrawMarker(20, Config.Markeri["lokacija9"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija9"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija9 = true
                    lokacija10 = false
                    SetNewWaypoint(Config.Markeri["lokacija10"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija10 == false  then
                DrawMarker(20, Config.Markeri["lokacija10"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija10"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija10 = true
                    lokacija11 = false
                    SetNewWaypoint(Config.Markeri["lokacija11"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija11 == false  then
                DrawMarker(20, Config.Markeri["lokacija11"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)

                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija11"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija11 = true
                    lokacija12 = false
                    SetNewWaypoint(Config.Markeri["lokacija12"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija12 == false  then
                DrawMarker(20, Config.Markeri["lokacija12"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija12"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija12 = true
                    lokacija13 = false
                    SetNewWaypoint(Config.Markeri["lokacija13"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija13 == false  then
                DrawMarker(20, Config.Markeri["lokacija13"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija13"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija13 = true
                    lokacija14 = false
                    SetNewWaypoint(Config.Markeri["lokacija14"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija14 == false  then
                DrawMarker(20, Config.Markeri["lokacija14"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija14"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true) 
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    })  
                    HelpNotify(Translation.EN["dalje"].label, 3000)
                    lokacija14 = true
                    lokacija15 = false
                    SetNewWaypoint(Config.Markeri["lokacija15"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija15 == false  then
                DrawMarker(20, Config.Markeri["lokacija15"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija15"].kordinata) <= 2.0 then 
                    FreezeEntityPosition(vozilo, true)
                    lib.progressCircle({
                        duration = Config.Cekanje,
                        label = Translation.EN["waiting"].label,
                        useWhileDead = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                })  
                HelpNotify(Translation.EN["putvehicleback"].label, 3000)
                    lokacija15 = true
                    lokacija16 = false
                    SetNewWaypoint(Config.Markeri["lokacija16"].kordinata)
                    FreezeEntityPosition(vozilo, false)
                end
            end
            if lokacija16 == false then
                DrawMarker(20, Config.Markeri["lokacija16"].kordinata + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 100, true, true, 2, nil, nil, false)
                    if #(GetEntityCoords(PlayerPedId()) - Config.Markeri["lokacija16"].kordinata) <= 2.0 then 
                    if stanje > 50 and stanje2 > 50 then
                        if greske > Config.MaxAllowedMistakes then 
                            lib.progressCircle({
                                duration = Config.Cekanje,
                                label = Translation.EN["parking"].label,
                                useWhileDead = false,
                                disable = {
                                    move = true,
                                    car = true,
                                    combat = true,
                                },
                            })  
                            local vrativozilo = GetLastDrivenVehicle(PlayerPedId())
                            DeleteVehicle(vrativozilo)
                            Notify(Translation.EN["failed"].label)
                            greske = 0
                            speedprovera = false
                            lokacija16 = true
                            for i = 1, #instruktor do 
                                DeletePed(instruktor[i])
                            end
                        else
                            lib.progressCircle({
                                duration = Config.Cekanje,
                                label = Translation.EN["parking"].label,
                                useWhileDead = false,
                                disable = {
                                    move = true,
                                    car = true,
                                    combat = true,
                                },
                            })  
                            local vrativozilo = GetLastDrivenVehicle(PlayerPedId())
                            DeleteVehicle(vrativozilo)
                            Notify(Translation.EN["sucsparked"].label)
                            TriggerServerEvent('gg:dajedozvolu', 'dmv')
                            speedprovera = false
                            lokacija16 = true
                            greske = 0 
                            for i = 1, #instruktor do 
                                DeletePed(instruktor[i])
                            end
                        end
                    else 
                        Notify(Translation.EN["ostetio"].label)
                    end
                end
            end
        end
    end
end)

function speedcheck()
    Wait(100)
    speedprovera = true
    CT(function()
        while true do
            Wait(10000)
            if speedprovera then
                
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local vozilo = GetVehiclePedIsIn(ped, false)
                    local entityspeed = GetEntitySpeed(vozilo)
                    local entityspeedconverter = entityspeed * Config.KPMP
                    print(entityspeedconverter)
                    if entityspeedconverter >= Config.MaxSpeed then
                        greske = greske + 2
                        Notify(Translation.EN["speedpenalty"].label)
                    end
                end
            else
                break
            end
        end
    end)
end