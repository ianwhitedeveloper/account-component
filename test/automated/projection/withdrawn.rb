require_relative '../automated_init'

context "Projection" do
  context "Withdrawn" do
    account = Account.new
    account.balance = 11

    withdrawn = Messages::Events::Withdrawn.new
    withdrawn.account_id = Identifier::UUID::Random.get
    withdrawn.amount = 1

    Projection.(account, withdrawn)

    test "Account balance is decreased" do
      assert(account.balance == 10)
    end
  end
end
