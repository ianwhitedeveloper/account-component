require_relative '../automated_init'

context "Projection" do
  context "Withdrawal Rejected" do
    account = Controls::Account::Balance.example

    withdrawal_rejected = Controls::Events::WithdrawalRejected.example

    position = withdrawal_rejected.sequence or fail

    Projection.(account, withdrawal_rejected)

    test "Transaction position is set" do
      assert(account.sequence == position)
    end
  end
end
