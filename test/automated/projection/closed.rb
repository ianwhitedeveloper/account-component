require_relative '../automated_init'

context "Projection" do
  context "Closed" do
    account = Controls::Account.example

    assert(account.closed_time.nil?)

    closed = Controls::Events::Closed.example

    account_id = closed.account_id or fail

    Projection.(account, closed)

    test "ID is set" do
      assert(account.id == account_id)
    end

    test "Closed time is converted and copied" do
      closed_time = Time.parse(closed.time)

      assert(account.closed_time == closed_time)
    end
  end
end
