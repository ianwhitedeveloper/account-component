require_relative './exercise_init'

account_id = Identifier::UUID::Random.get
deposit_id = Identifier::UUID::Random.get

deposit = Messages::Commands::Deposit.new
deposit.account_id = account_id
deposit.id = deposit_id
deposit.amount = 11
deposit.time = '2000-01-01T11:11:11.00000Z'

command_stream_name = "account:command-#{account_id}"


store = Store.build


Messaging::Postgres::Write.(deposit, command_stream_name)

EventSource::Postgres::Read.(command_stream_name) do |event_data|
  Handlers::Commands.(event_data)
end


account = store.fetch(account_id)
pp "Account #{account_id} balance: $#{account.balance}"


EventSource::Postgres::Read.(command_stream_name) do |event_data|
  Handlers::Commands.(event_data)
end


account = store.fetch(account_id)
pp "Account #{account_id} balance: $#{account.balance}"
