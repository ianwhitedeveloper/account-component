require_relative 'exercise_init'

account_id = Identifier::UUID::Random.get

withdrawn = Messages::Events::Withdrawn.new
withdrawn.account_id = account_id
withdrawn.amount = 11
withdrawn.time = '2000-01-01T11:11:11.00000Z'
withdrawn.processed_time = Clock.iso8601

stream_name = "account-#{account_id}"

Messaging::Postgres::Write.(withdrawn, stream_name)

account = Account.new
account.id = account_id

puts "Account #{account.id} balance: $#{account.balance}"

EventSource::Postgres::Read.(stream_name) do |event|
  Projection.(account, event)
end

puts "Account #{account.id} balance: $#{account.balance}"
