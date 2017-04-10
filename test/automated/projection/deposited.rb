require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    deposited = Controls::Events::Deposited.example

    Projection.(account, deposited)

    test "Account balance is increased" do
      assert(account.balance == prior_balance + deposited.amount)
    end
  end
end
