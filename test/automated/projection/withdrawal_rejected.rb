require_relative '../automated_init'

context "Projection" do
  context "Withdrawal Rejected" do
    withdrawal_rejected = Controls::Events::WithdrawalRejected.example

    context do
      account = Controls::Account::Balance.example

      position = withdrawal_rejected.sequence or fail

      Projection.(account, withdrawal_rejected)

      test "Transaction position is set" do
        assert(account.sequence == position)
      end
    end

    context "ID Is Set" do
      account = Controls::Account::New.example

      assert(account.id.nil?)
      account_id = withdrawal_rejected.account_id or fail

      Projection.(account, withdrawal_rejected)

      test do
        assert(account.id == account_id)
      end
    end
  end
end
