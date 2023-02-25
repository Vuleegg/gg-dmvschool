if Config.NewESX then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end
local RSE = RegisterServerEvent
local AEH = AddEventHandler 

ESX.RegisterServerCallback("gg:imal_za_B", function(source, cb, price)
  local igrac = ESX.GetPlayerFromId(source) 
    if igrac.getAccount(Config.Money).money >= price then
        cb(true) 
        igrac.removeAccountMoney(Config.Money, price)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, Prevod.Autoskola["nemapara"].label)
    end
end)

AddEventHandler('esx:playerLoaded', function(source)
    TriggerEvent('esx_license:getLicenses', source, function(licenses)
        TriggerClientEvent('gg-autoskola:ucitajLicence', source, licenses)
    end)
end)


RSE("gg:dajedozvolu")
AEH("gg:dajedozvolu", function(type)
    local igrac = ESX.GetPlayerFromId(source)
    if Config.Item == true then 
        igrac.addInventoryItem(Config.VozackaItem, 1)
    else
        TriggerEvent('esx_license:addLicense', source, type, function()
        TriggerEvent('esx_license:getLicenses', source, function(licenses)
        TriggerClientEvent('gg-autoskola:ucitajLicence', source, licenses) end) end) 
    end
end)