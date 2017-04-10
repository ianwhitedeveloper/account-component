require_relative '../automated_init'

context "Projection" do
  context "Opened" do
    account = Controls::Account::New.example

    assert(account.opened_time.nil?)

    opened = Controls::Events::Opened.example

    Projection.(account, opened)

    test "Open time is converted and copied" do
      opened_time = Time.parse(opened.time)

      assert(account.opened_time == opened_time)
    end
  end
end
