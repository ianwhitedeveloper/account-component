require_relative '../../automated_init'

context "Handle Commands" do
  context "Withdrawn" do
    handler = Handlers::Commands.new

    account_id = Identifier::UUID::Random.get

    amount = 1

    processed_time = Time.now

    handler.clock.now = processed_time

    account = Account.new
    account.id = account_id
    account.balance = 11

    handler.store.add(account_id, account)

    withdraw = Messages::Commands::Withdraw.new
    withdraw.account_id = account_id
    withdraw.amount = amount
    withdraw.time = '2000-01-01T11:11:11.00000Z'

    handler.(withdraw)

    writer = handler.write

    withdrawn = writer.one_message do |event|
      event.instance_of? Messages::Events::Withdrawn
    end

    test "Withdrawn Event is Written" do
      refute(withdrawn.nil?)
    end

    test "Written to the account stream" do
      written_to_stream = writer.written?(withdrawn) do |stream_name|
        stream_name == "account-#{account_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "account_id" do
        assert(withdrawn.account_id == account_id)
      end

      test "amount" do
        assert(withdrawn.amount == amount)
      end

      test "time" do
        assert(withdrawn.time == '2000-01-01T11:11:11.00000Z')
      end

      test "processed_time" do
        assert(withdrawn.processed_time == Clock::UTC.iso8601(processed_time))
      end
    end
  end
end
