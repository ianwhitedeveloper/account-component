module AccountComponent
  module Messages
    module Commands
      class Withdraw
        include Messaging::Message
# TEST REMOVE THIS
        attribute :account_id, String
        attribute :withdrawal_id, String
        attribute :amount, Numeric
        attribute :time, String
      end
    end
  end
end
