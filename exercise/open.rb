require_relative 'exercise_init'

account_id = Identifier::UUID::Random.get

open = Messages::Commands::Open.new
open.account_id = account_id
open.customer_id = Identifier::UUID::Random.get
open.time = '2000-01-01T11:11:11.00000Z'

command_stream_name = "account:command-#{account_id}"

# Write open command
Messaging::Postgres::Write.(open, command_stream_name)

EventSource::Postgres::Read.(command_stream_name) do |event_data|
  Handlers::Commands.(event_data)
end
