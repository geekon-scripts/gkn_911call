Config = {}

Config.BoothModels = {
    `prop_phonebox_01a`,
    `prop_phonebox_02_s`,
    `prop_phonebox_03`,
    `prop_phonebox_01a`,
    `prop_phonebox_01c`,
    `prop_phonebox_04`,
    `prop_phonebox_01b`
}


Config.CustomBooths = {
    -- { coords = vector3(-145.21, -1024.54, 27.28), heading = 0.0 }, CUSTOM COORDS FOR BOOTHS, YOU CAN ADD MORE PROPS :)
}

-- Cooldown in ms
Config.CallCooldown = 5 * 60 * 1000


Config.DispatchJobs = { 'police', 'sheriff', 'ambulance' }


Config.JobLabels = {
    police = 'LSPD',
    sheriff = 'Sheriff',
    ambulance = 'Ambulance'
}


Config.CallOptions = {
    { label = 'Police', value = 'police' },
    { label = 'Sheriff', value = 'sheriff' },
    { label = 'Ambulance', value = 'ambulance' },
}

Config.Locales = {
    targetLabel = 'Call 911',
    targetIcon = 'fas fa-phone',
    dialogTitle = 'Emergency Call',
    dialogService = 'Requested service',
    dialogName = 'Your name',
    dialogNamePlaceholder = 'Enter your name',
    dialogReason = 'What happened?',
    dialogReasonPlaceholder = 'Describe situation',
    calling = 'Calling...',
    notifyCooldownTitle = 'Emergency Call',
    notifyCooldownDesc = function(remaining) return 'You need to wait ' .. remaining .. ' before sending next call.' end,
    notifyCancelTitle = 'Emergency call was cancelled',
    notifySuccessTitle = 'Emergency Call',
    notifySuccessDesc = function(job) return 'Emergency call was sent to ' .. job end,
}

