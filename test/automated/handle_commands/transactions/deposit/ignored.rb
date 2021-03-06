require_relative '../../../automated_init'

context "Handle Commands" do
  context "Transactions" do
    context "Deposit" do
      context "Ignored" do
        handler = Handlers::Commands::Transactions.new

        deposit = Controls::Commands::Deposit.example

        account = Controls::Account::Position.example

        assert(account.current?(deposit.metadata.global_position))

        handler.store.add(account.id, account)

        handler.(deposit)

        writer = handler.write

        deposited = writer.one_message do |event|
          event.instance_of?(Messages::Events::Deposited)
        end

        test "Deposited Event is not Written" do
          assert(deposited.nil?)
        end
      end
    end
  end
end
