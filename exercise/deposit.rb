require_relative 'exercise_init'

deposit = Messages::Commands::Deposit.new
deposit.account_id = '123'
deposit.amount = 11
deposit.time = '2000-01-01T11:11:11.00000Z'

stream_name = 'account-123'

Messaging::Postgres::Write.(deposit, stream_name)
