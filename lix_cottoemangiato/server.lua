ESX.RegisterServerCallback('lix:PrendiSoldi', function(src, cb, prezzo)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getAccount('bank').money >= prezzo then
        xPlayer.removeAccountMoney('bank', prezzo)
        cb(true)
    else
        xPlayer.showNotification('Non hai abbastanza soldi!')
        cb(false)
    end
end) 

