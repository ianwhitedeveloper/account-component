require_relative '../automated_init'

context "Projection" do
  context "Withdrawn" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    withdrawn = Controls::Events::Withdrawn.example

    Projection.(account, withdrawn)

    test "Account balance is decreased" do
      assert(account.balance == prior_balance - withdrawn.amount)
    end
  end
end
