require_relative '../automated_init'

context "Projection" do
  context "Withdrawn" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    withdrawn = Controls::Events::Withdrawn.example

    position = withdrawn.transaction_position or fail

    Projection.(account, withdrawn)

    test "Account balance is decreased" do
      assert(account.balance == prior_balance - withdrawn.amount)
    end

    test "Transaction position is set" do
      assert(account.transaction_position == position)
    end
  end
end
