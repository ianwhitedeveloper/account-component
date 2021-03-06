require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

deposited = Messages::Events::Deposited.new
deposited.account_id = account_id
deposited.amount = 11
deposited.time = '2000-01-01T11:11:11.000Z'
deposited.processed_time = Clock.iso8601

stream_name = "account-#{account_id}"

Messaging::Postgres::Write.(deposited, stream_name)

EventSource::Postgres::Read.(stream_name) do |event|
  pp event
end
