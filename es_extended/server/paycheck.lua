ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local jobname = xPlayer.job.name
			local jobgrade	= xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary
			local joblabel = xPlayer.job.label
			local gradelabel = xPlayer.job.grade_label
			local money = xPlayer.getAccount('bank').money

			if salary > 0 then
				if job == 'unemployed' then -- unemployed
					xPlayer.addAccountMoney('bank', salary)
					--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
					TriggerClientEvent("FeedM:showAdvancedNotification", xPlayer.source,  'Bank GoldenLeaks', '~y~Stan Konta: ~g~' ..money..'$', 'Otrzymano wypłatę:\n~y~' ..joblabel.. ' - ' ..gradelabel.. ': ~g~$' ..salary, 'char_taxi', 4000, 'primary')
				elseif Config.EnableSocietyPayouts then -- possibly a society
					TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then -- verified society
							TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then -- does the society money to pay its employees?
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)

									-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'char_hunter', 9)
									TriggerClientEvent("FeedM:showAdvancedNotification", xPlayer.source,  '~y~Bank GoldenLeaks', '~y~Stan Konta: ~g~' ..money..'$', 'Otrzymano wypłatę:\n~y~' ..joblabel.. ' - ' ..gradelabel, 'char_taxi', 4000, 'primary')
								else
									-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'char_hunter', 1)
									TriggerClientEvent("FeedM:showAdvancedNotification", xPlayer.source,  _U('bank'), '', _U('company_nomoney'), 'char_taxi', 4000, 'warning')
								end
							end)
						else -- not a society
							xPlayer.addAccountMoney('bank', salary)
							-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'char_hunter', 9)
							TriggerClientEvent("FeedM:showAdvancedNotification", xPlayer.source,  _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'char_taxi', 4000, 'primary')
						end
					end)
				else -- generic job
					xPlayer.addAccountMoney('bank', salary)
					-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'char_hunter', 9)
					TriggerClientEvent("FeedM:showAdvancedNotification", xPlayer.source,  'Bank GoldenLeaks', '~y~Stan Konta: ~g~' ..money..'$', 'Otrzymano wypłatę:\n~y~' ..joblabel.. ' - ' ..gradelabel.. ': ~g~$' ..salary, 'char_hunter', 4000, 'primary')
				end
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end