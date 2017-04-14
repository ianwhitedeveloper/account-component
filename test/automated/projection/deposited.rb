require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    deposited = Controls::Events::Deposited.example

    position = deposited.sequence or fail

    Projection.(account, deposited)

    test "Account balance is increased" do
      assert(account.balance == prior_balance + deposited.amount)
    end

    test "Transaction position is set" do
      assert(account.sequence == position)
    end
  end
end
