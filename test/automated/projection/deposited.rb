require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    deposited = Controls::Events::Deposited.example

    position = deposited.transaction_position and refute(position.nil?)

    Projection.(account, deposited)

    test "Account balance is increased" do
      assert(account.balance == prior_balance + deposited.amount)
    end

    test "Transaction position is set" do
      assert(account.transaction_position == position)
    end
  end
end
