CreateThread(function()
    for _, model in pairs(Config.BoothModels) do
        exports.ox_target:addModel(model, {
            {
                label = Config.Locales.targetLabel,
                icon = Config.Locales.targetIcon,
                onSelect = function()
                    call911()
                end
            }
        })
    end
end)

CreateThread(function()
    local model = `prop_phonebox_01a`
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    for _, data in pairs(Config.CustomBooths) do
        local obj = CreateObject(model, data.coords.x, data.coords.y, data.coords.z - 1.0, false, false, true)
        SetEntityHeading(obj, data.heading)
        FreezeEntityPosition(obj, true)
        SetEntityInvincible(obj, true)
        SetEntityAsMissionEntity(obj, true, true)

        exports.ox_target:addLocalEntity(obj, {
            {
                label = Config.Locales.targetLabel,
                icon = Config.Locales.targetIcon,
                onSelect = function()
                    call911()
                end
            }
        })
    end
end)

local lastCallTime = 0

function call911()
    local currentTime = GetGameTimer()
    if currentTime - lastCallTime < Config.CallCooldown then
        local remaining = math.ceil((Config.CallCooldown - (currentTime - lastCallTime)) / 1000)
        lib.notify({
            title = Config.Locales.notifyCooldownTitle,
            description = Config.Locales.notifyCooldownDesc(remaining),
            type = 'error'
        })
        return
    end

    lastCallTime = currentTime

    local ped = PlayerPedId()
    local animDict = "cellphone@"
    local animName = "cellphone_call_listen_base"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end

    TaskPlayAnim(ped, animDict, animName, 2.0, 2.0, -1, 49, 0, false, false, false)

    lib.progressBar({
        duration = 3000,
        label = Config.Locales.calling,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
    })

    local input = lib.inputDialog(Config.Locales.dialogTitle, {
        {
            type = 'select',
            label = Config.Locales.dialogService,
            options = Config.CallOptions,
            required = true
        },
        {
            type = 'input',
            label = Config.Locales.dialogName,
            placeholder = Config.Locales.dialogNamePlaceholder,
            required = true
        },
        {
            type = 'textarea',
            label = Config.Locales.dialogReason,
            placeholder = Config.Locales.dialogReasonPlaceholder,
            required = true
        }
    })

    ClearPedTasks(ped)

    if not input then
        lib.notify({ type = 'error', title = Config.Locales.notifyCancelTitle })
        return
    end

    local job, name, reason = input[1], input[2], input[3]
    local data = exports['cd_dispatch']:GetPlayerInfo()
    local serviceName = Config.JobLabels[job] or 'Neznámá služba'

    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.DispatchJobs,
        coords = data.coords,
        title = name .. ' volá ' .. serviceName .. '!',
        message = reason .. ' | Lokace: ' .. data.street,
        flash = 1,
        unique_id = data.unique_id,
        sound = 1,
        blip = {
            sprite = 162,
            scale = 1.2,
            colour = 3,
            flashes = true,
            text = 'Tísňové volání',
            time = 5,
            radius = 0,
        }
    })

    lib.notify({
        title = Config.Locales.notifySuccessTitle,
        description = Config.Locales.notifySuccessDesc(job),
        type = 'success'
    })
end

