module AccountComponent
  module Controls
    module Events
      module WithdrawalRejected
        def self.example
          withdrawal_rejected = AccountComponent::Messages::Events::WithdrawalRejected.build

          withdrawal_rejected.account_id = Account.id
          withdrawal_rejected.amount = Money.example
          withdrawal_rejected.time = Controls::Time::Effective.example

          withdrawal_rejected.sequence = Position.example

          withdrawal_rejected
        end
      end
    end
  end
end
