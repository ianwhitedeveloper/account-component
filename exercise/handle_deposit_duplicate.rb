require_relative './exercise_init'

account_id = Identifier::UUID::Random.get
deposit_id = Identifier::UUID::Random.get

deposit = Messages::Commands::Deposit.new
deposit.account_id = account_id
deposit.deposit_id = deposit_id
deposit.amount = 11
deposit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "account:command-#{account_id}"
transaction_stream_name = "accountTransaction-#{deposit_id}"


store = Store.build


2.times do
  Messaging::Postgres::Write.(deposit, command_stream_name)
end


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


EventSource::Postgres::Read.(command_stream_name) do |event_data|
  Handlers::Commands.(event_data)
end

puts "Handling transaction commands"

EventSource::Postgres::Read.(transaction_stream_name) do |event_data|
  Handlers::Commands::Transactions.(event_data)
end


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"
