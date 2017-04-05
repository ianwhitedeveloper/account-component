require_relative '../automated_init'

context "Handle Commands" do
  context "Deposit" do
    handler = Handlers::Commands.new

    processed_time = Time.now

    handler.clock.now = processed_time

    deposit = Messages::Commands::Deposit.new
    deposit.account_id = '123'
    deposit.amount = 11
    deposit.time = '2000-01-01T11:11:11.00000Z'

    handler.(deposit)

    writer = handler.write

    deposited = writer.one_message do |event|
      event.instance_of? Messages::Events::Deposited
    end

    test "Deposited Event is Written" do
      refute(deposited.nil?)
    end

    test "Written to the account-123 stream" do
      written_to_stream = writer.written?(deposited) do |stream_name|
        stream_name == 'account-123'
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "account_id" do
        assert(deposited.account_id == '123')
      end

      test "amount" do
        assert(deposited.amount == 11)
      end

      test "time" do
        assert(deposited.time == '2000-01-01T11:11:11.00000Z')
      end

      test "processed_time" do
        assert(deposited.processed_time == Clock::UTC.iso8601(processed_time))
      end
    end
  end
end
