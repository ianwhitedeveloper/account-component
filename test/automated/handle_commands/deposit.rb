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

    test "Deposited Event is Written" do
      written = writer.written? do |message|
        message.instance_of? Messages::Events::Deposited
      end

      assert(written)
    end

    test "Written to the account-123 stream" do
      written_to_stream = writer.written? do |_, stream_name|
        stream_name == 'account-123'
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "account_id" do
        written = writer.written? do |message|
          message.account_id == '123'
        end

        assert(written)
      end

      test "amount" do
        written = writer.written? do |message|
          message.amount == 11
        end

        assert(written)
      end

      test "time" do
        written = writer.written? do |message|
          message.time == '2000-01-01T11:11:11.00000Z'
        end

        assert(written)
      end

      test "processed_time" do
        written = writer.written? do |message|
          message.processed_time == Clock::UTC.iso8601(processed_time)
        end

        assert(written)
      end
    end
  end
end
