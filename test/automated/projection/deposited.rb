require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    account = Account.new
    account.balance = 1

    deposited = Messages::Events::Deposited.new
    deposited.account_id = Identifier::UUID::Random.get
    deposited.amount = 11

    Projection.(account, deposited)

    test "Account balance is increased" do
      assert account.balance == 12
    end
  end
end
