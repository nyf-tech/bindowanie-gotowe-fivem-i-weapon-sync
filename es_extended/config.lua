Config                      = {}
Config.Locale               = 'pl'

Config.Accounts             = { 'bank', 'black_money' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') }

Config.EnableSocietyPayouts = false
Config.ShowDotAbovePlayer   = false
Config.DisableWantedLevel   = true
Config.DisableNpcWeaponDrop = true
Config.SeatShuff = true
Config.EnableHud            = true

Config.PaycheckInterval     = 7 * 60000
Config.MaxPlayers           = GetConvarInt('sv_maxclients', 255)

Config.EnableDebug          = false
