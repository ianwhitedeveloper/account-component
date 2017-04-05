require_relative 'exercise_init'

deposited = Messages::Events::Deposited.new
deposited.account_id = '123'
deposited.amount = 11
deposited.time = '2000-01-01T11:11:11.00000Z'
deposited.processed_time = Clock.iso8601

stream_name = 'account-123'

Messaging::Postgres::Write.(deposited, stream_name)
